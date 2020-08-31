extends "res://scripts/character/Character.gd"

func _ready():
	self.connect("death", self, "_on_death")
	
func _on_death():
	self.get_parent().call_deferred("remove_child", self)
