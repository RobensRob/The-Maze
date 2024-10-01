extends Interactable

@onready var player = $"../../Player"

func get_interaction_text():
	return ""

func interact():
	if player.get_key_from_inventory_by_name("Invisible Door"):
		player.position = get_meta("Teleport_To")
