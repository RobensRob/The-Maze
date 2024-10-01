extends CharacterBody3D

const CAM_SPEED = .6
const BASE_SPEED = 3.0
const SPRINT_SPEED = BASE_SPEED + 3.0
const STAMINA_SPEED = 30

var stamina : float = 100.0
var sprinting = false

var keys = []

@onready var camera = $Camera3D
@onready var stamina_bar = $Control/StaminaBar

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _unhandled_input(event):
	if event is InputEventMouseButton:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	elif event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			rotate_y(-event.relative.x * 0.01 * CAM_SPEED)
			camera.rotate_x(-event.relative.y * 0.01 * CAM_SPEED)
			camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-90), deg_to_rad(90))

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta

	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		if sprinting:
			velocity.x = direction.x * SPRINT_SPEED
			velocity.z = direction.z * SPRINT_SPEED
		else:
			velocity.x = direction.x * BASE_SPEED
			velocity.z = direction.z * BASE_SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, BASE_SPEED)
		velocity.z = move_toward(velocity.z, 0, BASE_SPEED)
	move_and_slide()

func _process(delta):
	if Input.is_action_pressed("sprint"):
		if stamina > 0:
			sprinting = true
			stamina -= 1 * delta * STAMINA_SPEED
		else:
			sprinting = false
	else:
		sprinting = false
		stamina += 1 * delta * STAMINA_SPEED / 2
	stamina = clamp(stamina, 0, 100)
	stamina_bar.value = stamina

func _on_teleport_trigger_body_entered(body):
	position.z -= 10.5

func add_key_to_inventory(element):
	keys.append(element)

func get_key_from_inventory_by_name(name):
	for key in keys:
		if key == name:
			return key
	return null
