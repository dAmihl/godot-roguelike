class_name CharacterStats

export var max_health: int = 5
export var max_atk: int = 1
export var max_def: int = 1

onready var health: int = 0
onready var atk: int = 0
onready var def: int = 0
onready var con:int = 1

signal health_depleted
signal damage_received
signal healing_received
signal health_changed

func _init():
	health = max_health
	atk = max_atk
	def = max_def
	con = 1

func give_damage(amount:int, source) -> void:
	# dont want this to be abused by accident
	amount = abs(amount)
	# this could be affected by def stat
	var effective_amount:int = amount
	var old_health = health
	health = max(health-effective_amount, 0)
	emit_signal("damage_received", effective_amount, source)
	emit_signal("health_changed", old_health, health)
	if ( health == 0 ):
		emit_signal("health_depleted")

func give_health(amount:int, source) -> void:
	# dont want this to be abused by accident
	amount = abs(amount)
	# this could be affected by stats
	var effective_amount = amount
	var old_health = health
	health = min(health+effective_amount, max_health)
	emit_signal("healing_received", effective_amount, source)
	emit_signal("health_changed", old_health, health)
