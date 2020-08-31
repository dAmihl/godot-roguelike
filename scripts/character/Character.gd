extends Node2D

var pos_in_map:Vector2 = Vector2(0,0)
onready var map_node: Node2D = get_node("../Map")

onready var stats: CharacterStats = CharacterStats.new()

signal death

func _ready():
	_set_new_position(pos_in_map)
	stats.connect("damage_received", self, "_on_Damage_Received")
	stats.connect("health_received", self, "_on_Health_Received")
	stats.connect("health_depleted", self, "_on_Health_Depleted")
	pass

func move(direction:Vector2) -> void:
	var new_pos:Vector2 = map_node.try_move_to(pos_in_map, direction)
	if ( new_pos != pos_in_map ):
		_set_new_position(new_pos)

func _set_new_position(new_pos:Vector2) -> void:
	pos_in_map = new_pos
	self.position = map_node.map_to_world(pos_in_map)

func _on_Damage_Received(amount:int) -> void:
	print("Received Damage: "+str(amount))

func _on_Health_Received(amount:int) -> void:
	print("Received Health: "+str(amount))

func _on_Health_Depleted() -> void:
	emit_signal("death")
