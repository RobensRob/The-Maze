extends CharacterBody3D

enum ACTION_MODE {wandering, hunting, hiding, crying}

@export var gridmap : GridMap
@export var navigation : NavigationRegion3D

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
	var destination_position = Vector3(0, 1, 0)
	var path = (destination_position - position).normalized() * WANDERING_SPEED
	velocity = path
	if position == destination_position:
		print("lol")

func action_hiding():
	position = Vector3(0, 20, 0)

func trigger_monster():
	triggered = true
	# TODO: Play Sound and visual effects

func choose_random_target():
	var walkable_positions = get_walkable_positions_from_gridmap()

func get_walkable_positions_from_gridmap() -> Array:
	var positions = []
	var grid_size = gridmap.cell_size
	for x in range(gridmap.get_used_cells().size().x):
		for z in range(gridmap.get_used_cells().size().z):
			var cell = Vector3(x, 1, z)
			if gridmap.get_cell_item(cell) == -1:
				var world_position = gridmap.map_to_local(cell) + gridmap.cell_size / 2
				positions.append(world_position)
	return positions
	
func _on_monster_trigger_body_entered(body):
	trigger_monster()
