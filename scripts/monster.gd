extends CharacterBody3D

enum ACTION_MODE {wandering, hunting, hiding, crying}

@export var gridmap : GridMap
@export var navigation : NavigationRegion3D

@onready var navigation_agent_3d = $NavigationAgent3D

var triggered = false
var current_mode = ACTION_MODE.wandering

const WANDERING_SPEED = 1
const SPEED = 5.0

func _physics_process(delta):
	if triggered:
		if current_mode == ACTION_MODE.wandering:
			action_wandering()
		elif current_mode == ACTION_MODE.hunting:
			print("hunting")
		elif current_mode == ACTION_MODE.hiding:
			action_hiding()
		elif current_mode == ACTION_MODE.crying:
			print("crying")
	move_and_slide()

func action_wandering():
	var destination_position = Vector3(17, 1, 2)
	navigation_agent_3d.set_target_position(destination_position)
	
	var destination = navigation_agent_3d.get_next_path_position()
	var local_destination = destination - global_position
	var direction = local_destination.normalized()
	
	velocity = direction * 5.0

func action_hiding():
	position = Vector3(0, 20, 0)

func trigger_monster():
	triggered = true
	# TODO: Play Sound and visual effects
	
func _on_monster_trigger_body_entered(body):
	trigger_monster()
