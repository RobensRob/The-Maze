class_name Key extends Interactable

@onready var key = $"."
@onready var player = $"../../../Player"

var door_name

func _ready():
	door_name = "Invisible Door"

func get_door_name():
	return door_name

func get_interaction_text():
	return "Press E to pick up"

func interact():
	player.add_key_to_inventory(get_door_name())
	queue_free()
