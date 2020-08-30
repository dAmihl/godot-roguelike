class_name Matrix

var size_n: int = 3
var size_m: int = 3

var data:Array = []

func _init(n:int, m:int, default_value = 0):
	self.size_n = n
	self.size_m = m
	if !default_value is bool or default_value == false:
		_init_data_with_default_value(default_value)

func _init_data_with_default_value(default_val):
	for i in range(self.size_n):
		self.data.append([])
		for j in range(self.size_m):
			self.data[i].append(default_val)

func get_value_at(i:int, j:int):
	if i >= size_n or j >= size_m or i < 0 or j < 0:
		return false
	return self.data[i][j]

func get_value_at_vec2(pos:Vector2):
	return get_value_at(pos.x, pos.y)

func set_value_at(val, i:int, j:int):
	self.data[i][j] = val

func get_width():
	return self.size_n

func get_height():
	return self.size_m

func set_data(custom_data:Array):
	self.data = custom_data

func find_adjacent_cell_with_value(start_pos:Vector2, find_val)->Vector2:
	var test_vecs = [
		Vector2(0,1),
		Vector2(1,0),
		Vector2(0,-1),
		Vector2(-1,0)
	]
	
	for test_vec in test_vecs:
		var tmp_val = get_value_at_vec2(start_pos+test_vec)
		if !tmp_val is bool and tmp_val == find_val:
			return test_vec
	return Vector2.ZERO
