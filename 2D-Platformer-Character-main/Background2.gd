extends ColorRect


func _ready():
	update_lives()

func update_lives():
	$Lives.text = "Remaining Lives: " + str(Global.lives)
