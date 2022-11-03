extends Control


func _on_Play_Again_pressed():
	Global.score = 0
	Global.time = 0
	Global.lives = 5
	var _scene = get_tree().change_scene("res://Game.tscn")
