extends Node2D

onready var Bat = load("res://Enemy/Bat.tscn")
var Multi=1


func _physics_process(_delta):
	randomize()
	if Global.time > 10:
		Multi = 2
	if Global.time > 20:
		Multi = 4
	if Global.time > 30:
		Multi = 5
	if Global.time > 40:
		Multi = 10
	if Global.time > 50:
		Multi = 20
	var random = (randi()%(100/Multi))
	if random == 1:
		var bat = Bat.instance()
		add_child(bat)
		bat.name = 'Bat'

