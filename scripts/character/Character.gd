extends Node2D

var pos_in_map:Vector2 = Vector2(0,0)
onready var map_node: Node2D = get_node("../Map")

func _ready():
	_set_new_position(pos_in_map)
	pass # Replace with function body.

func move(direction:Vector2) -> void:
	var new_pos:Vector2 = map_node.try_move_to(pos_in_map, direction)
	if ( new_pos != pos_in_map ):
		_set_new_position(new_pos)

func _set_new_position(new_pos:Vector2) -> void:
	pos_in_map = new_pos
	self.position = map_node.map_to_world(pos_in_map)
