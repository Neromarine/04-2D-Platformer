extends Control

var lives_pos = Vector2.ZERO
var lives_index = 30

onready var indicator = load("res://UI/Indicator.tscn")

func _ready():
	pass

func update_lives():
	lives_pos = Vector2(20,Global.VP.y - 20)
	for child in $indicator_container.get_children():
		child.queue_free()
	for i in range(Global.lives):
		var Indicator = indicator.instance()
		Indicator.position = Vector2(lives_pos.x + i*lives_index, lives_pos.y)
		$indicator_container.add_child(Indicator)
