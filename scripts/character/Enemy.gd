extends "res://scripts/character/Character.gd"

func _ready():
	self.connect("death", self, "_on_death")
	self.character_name = "Enemy"

func _on_death():
	self.get_parent().call_deferred("remove_child", self)

func _on_Damage_Received(amount:int, source) -> void:
	._on_Damage_Received(amount, source)
	source.stats.give_damage(1,self)
