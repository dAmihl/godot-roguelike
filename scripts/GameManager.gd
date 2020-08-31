extends Node2D

onready var gui_node: Control = get_node("../CanvasLayer/GUI")

func register_character(character) -> void:
	character.connect("combat_log", self, "_on_log_message")
	pass
	
func _on_log_message(log_msg:String) -> void:
	gui_node.log_message(log_msg)
	pass

func player_death():
	get_tree().reload_current_scene()
