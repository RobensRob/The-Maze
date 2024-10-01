extends RayCast3D

var current_collider

@onready var label = $"../../Control/Label"

func _ready():
	set_interaction_text("")

func _process(delta):
	var collider = get_collider()
	if is_colliding() && collider is Interactable:
		if current_collider != collider:
			set_interaction_text(collider.get_interaction_text())
			current_collider = collider
		if Input.is_action_just_pressed("interact"):
			collider.interact()
			set_interaction_text(collider.get_interaction_text())
	elif current_collider:
		current_collider = null
		set_interaction_text("")

func set_interaction_text(text):
	if !text:
		label.set_text("")
		label.set_visible(false)
	else:
		label.set_text(text)
		label.set_visible(true)
