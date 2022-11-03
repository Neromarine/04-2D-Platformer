extends KinematicBody2D

onready var SM = $StateMachine

var velocity = Vector2.ZERO
var jump_power = Vector2.ZERO
var direction = 1

export var gravity = Vector2(0,0)

export var move_speed = 0
export var max_move = 0

export var jump_speed = 0
export var max_jump = 0

export var leap_speed = 0
export var max_leap = 0

var moving = false
var is_jumping = false
var double_jumped = false
var should_direction_flip = true # wether or not player controls (left/right) can flip the player sprite

var Attacking = false;
var AttackNum = 0

func _physics_process(_delta):
	is_on_floor()
	velocity.x = clamp(velocity.x,-max_move,max_move)
	if Input.is_action_just_pressed("Attack"):
		if AttackNum < 3:
			AttackNum += 1
		if $AnimatedSprite.frames.has_animation("Attack1") and AttackNum == 1:
			Attacking = true
			$AnimatedSprite.play("Attack1")
			$Attack1Timer.start()
	
	if Attacking == true:
		if direction == 1:
			$Area2D.monitoring = true
			$Area2D/AttackCSRight.disabled = false
		if direction == -1:
			$Area2D.monitoring = true
			$Area2D/AttackCSLeft.disabled = false
	else:
		$Area2D.monitoring = false
		$Area2D/AttackCSLeft.disabled = true
		$Area2D/AttackCSRight.disabled = true
		
			
		

	if should_direction_flip:
		if direction < 0 and not $AnimatedSprite.flip_h: $AnimatedSprite.flip_h = true
		if direction > 0 and $AnimatedSprite.flip_h: $AnimatedSprite.flip_h = false
	
	if is_on_floor():
		double_jumped = false
		set_wall_raycasts(true)

func is_moving():
	if Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		return true
	return false

func move_vector():
	return Vector2(Input.get_action_strength("right") - Input.get_action_strength("left"),1.0)

func _unhandled_input(event):
	if event.is_action_pressed("left"):
		direction = -1
	if event.is_action_pressed("right"):
		direction = 1

func set_animation(anim):
	if Attacking == false:
		if $AnimatedSprite.animation == anim: return
		if $AnimatedSprite.frames.has_animation(anim): $AnimatedSprite.play(anim)
		else: $AnimatedSprite.play()

func is_on_floor():
	var fl = $Floor.get_children()
	for f in fl:
		if f.is_colliding():
			return true
	return false

func is_on_right_wall():
	if $Wall/Right.is_colliding():
		return true
	return false

func is_on_left_wall():
	if $Wall/Right.is_colliding():
		return true
	return false

func get_right_collider():
	return $Wall/Right.get_collider()

func get_left_collider():
	return $Wall/Left.get_collider()
	
func set_wall_raycasts(is_enabled):
	$Wall/Left.enabled = is_enabled
	$Wall/Right.enabled = is_enabled

func die():
	Global.update_life(1)
	queue_free()

func _on_Attack1Timer_timeout():
	if AttackNum >= 2:
		if $AnimatedSprite.frames.has_animation("Attack2"):
			$AnimatedSprite.play("Attack2")
			$Attack2Timer.start()
	elif AttackNum == 1:
		Attacking = false
		AttackNum = 0
		if $AnimatedSprite.frames.has_animation($StateMachine.state_name):
			$AnimatedSprite.play($StateMachine.state_name)
		


func _on_Attack2Timer_timeout():
	if AttackNum == 3:
		if $AnimatedSprite.frames.has_animation("Attack3"):
			$AnimatedSprite.play("Attack3")
			$Attack3Timer.start()

	elif AttackNum <= 2:
		Attacking = false
		AttackNum = 0
		if $AnimatedSprite.frames.has_animation($StateMachine.state_name):
			$AnimatedSprite.play($StateMachine.state_name)

func _on_Attack3Timer_timeout():
	if $AnimatedSprite.frames.has_animation($StateMachine.state_name):
		$AnimatedSprite.play($StateMachine.state_name)
	Attacking = false
	AttackNum = 0


func _on_Area2D_body_entered(body):
	var EC = get_node_or_null("/root/Game/Enemy_Container")
	if EC != null:
		var list = EC.get_children()
		for i in len(list):
			if body.name == list[i].name:
				body.die()
