extends Spatial

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_color(new_color:Color):
	$Viewport/Label.add_color_override("font_color", new_color)

func scroll_text(text:String, duration:float = 1.0, custom_color:Color = Color.white):
	set_color(custom_color)
	$Viewport/Label.text = text
	#$Viewport.size = $Viewport/Label.rect_size
	$AnimationPlayer.play("float_up")
	$Sprite3D.visible = true
	yield(get_tree().create_timer(duration), "timeout")
	$Sprite3D.visible = false
	$AnimationPlayer.stop(true)
	$Viewport/Label.text = ""
	self.queue_free()
	pass
