extends Node

var score = 0
var lives = 5
var time = 0

func _unhandled_input(event):
	if event.is_action_pressed("quit"):
		get_tree().quit()


func update_score(s):
	score = score + s
	var BG1 = get_node_or_null("/root/Game/Camera/CanvasLayer/Background1")
	if BG1 != null:
		BG1.update_score()
		
func update_life(s):
	lives = lives - s
	if lives <= 0:
		var _scene = get_tree().change_scene("res://UI/End_Game.tscn")
	var BG1 = get_node_or_null("/root/Game/Camera/CanvasLayer/Background2")
	if BG1 != null:
		BG1.update_lives()
		


