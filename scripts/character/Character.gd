extends Node2D

var pos_in_map:Vector2 = Vector2(0,0)
onready var map_node: Node2D = get_node("../Map")
onready var game_manager:Node2D = get_node("../GameManager")
onready var stats: CharacterStats = CharacterStats.new()

export var character_name:String = "GenericCharacter"

signal death
signal combat_log

func _ready():
	_set_new_position(pos_in_map)
	stats.connect("damage_received", self, "_on_Damage_Received")
	stats.connect("health_received", self, "_on_Health_Received")
	stats.connect("health_depleted", self, "_on_Health_Depleted")
	game_manager.register_character(self)
	pass

func move(direction:Vector2) -> void:
	var new_pos:Vector2 = map_node.try_move_to(pos_in_map, direction)
	if ( new_pos != pos_in_map ):
		_set_new_position(new_pos)

func _set_new_position(new_pos:Vector2) -> void:
	pos_in_map = new_pos
	self.position = map_node.map_to_world(pos_in_map)

func _on_Damage_Received(amount:int, source) -> void:
	combat_log(self.character_name + " received "+str(amount)+" damage from "+source.character_name)

func _on_Health_Received(amount:int, source) -> void:
	combat_log(self.character_name + " received "+str(amount)+" health from "+source.character_name)

func _on_Health_Depleted() -> void:
	emit_signal("death")
	combat_log(self.character_name + " died.")

func combat_log(msg:String)->void:
	emit_signal("combat_log", msg)
