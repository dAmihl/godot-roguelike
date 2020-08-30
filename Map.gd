extends TileMap

var map_size: int = 10

const enemy_scn = preload("res://Enemy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_enemies()
	pass # Replace with function body.

func generate_map():
	for i in range(map_size):
		for j in range(map_size):
			var val = 0
			if i == 0 or j == 0 or i == map_size-1 or j == map_size-1:
				val = 1
			self.set_cell(i,j,val)
	pass

func get_starting_pos() -> Vector2:
	return find_starting_pos()
	
func find_starting_pos() -> Vector2:
	for tile_position in get_used_cells():
		if get_cellv(tile_position) == tile_set.find_tile_by_name("Door"):
			return tile_position
	return get_used_cells()[0]

func try_move_to(from_pos:Vector2, direction:Vector2) -> Vector2:
	var target_pos = from_pos + direction
	var new_pos = target_pos
	var target_val = get_cellv(target_pos)
	if (target_val != tile_set.find_tile_by_name("FloorW")):
		return from_pos
	return new_pos

func spawn_enemies():
	for tile_position in get_used_cells():
		if get_cellv(tile_position) == tile_set.find_tile_by_name("Enemy"):
			var new_enemy = enemy_scn.instance()
			new_enemy.pos_in_map = tile_position
			get_parent().call_deferred("add_child", new_enemy)
			set_cellv(tile_position, 0)

func has_enemy(posv:Vector2) -> bool:
	var space_state = get_world_2d().direct_space_state
	var result = space_state.intersect_point(map_to_world(posv),32, [], 2147483647, true, true)
	return result
