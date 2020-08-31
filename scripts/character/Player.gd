extends "res://scripts/character/Character.gd"


# Called when the node enters the scene tree for the first time.
func _ready():
	set_starting_pos()
	pass # Replace with function body.

func set_starting_pos():
	var starting_pos = map_node.get_starting_pos()
	_set_new_position(starting_pos)
	pass

func _input(event):
	var direction = Vector2(0,0)
	if event.is_action_pressed("ui_left"):
		direction = Vector2(-1,0)
	if event.is_action_pressed("ui_right"):
		direction = Vector2(1,0)
	if event.is_action_pressed("ui_up"):
		direction = Vector2(0,-1)
	if event.is_action_pressed("ui_down"):
		direction = Vector2(0,1)
	if direction != Vector2(0,0):
		determine_action(direction)

func attack(enemy_data:Dictionary) -> void:
	var enemy = enemy_data.collider
	enemy.stats.give_damage(2)
	pass

func determine_action(direction:Vector2) -> void:
	var target_pos = pos_in_map + direction
	var enemy = map_node.has_enemy(target_pos)
	if ( enemy ):
		# We only attack the first enemy. There shouldnt be more anyway
		attack(enemy[0])
		return
	var map_val = map_node.get_cellv(target_pos)
	match map_val:
		0: move(direction)
