extends ColorRect


func _ready():
	update_score()



func _on_Timer_timeout():
	Global.time = Global.time + 1
	$Time.text = "Time Survived: " + str(Global.time)

func update_score():
	$Score.text = "Score: " + str(Global.score)
