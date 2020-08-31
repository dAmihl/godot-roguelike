extends Control


onready var player_node:Node2D = get_node("../../Player")

onready var log_node:RichTextLabel = find_node("Log")

onready var health_text:Label = find_node("HealthText")
onready var atk_text:Label = find_node("AtkText")
onready var def_text:Label = find_node("DefText")
onready var con_text:Label = find_node("ConText")

# Called when the node enters the scene tree for the first time.
func _ready():
	player_node.stats.connect("health_changed", self, "_on_health_changed")
	health_text.text = str(player_node.stats.health)
	atk_text.text = str(player_node.stats.atk)
	def_text.text = str(player_node.stats.def)
	con_text.text = str(player_node.stats.con)
	pass # Replace with function body.

func _on_health_changed(old_health, new_health):
	health_text.text = str(new_health)

func log_message(msg:String)->void:
	log_node.text += (msg + "\n")
