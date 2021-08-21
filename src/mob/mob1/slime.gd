extends KinematicBody2D
var slime_hp = 10
var move_where = 0
var speed = 150
var vel = Vector2()
signal idle

func _ready():
	pass

func _process(delta):
	#print(vel)
	#print(move_where)
	$Camera2D/Label2.text = str(slime_hp) + "/10"
	if move_where == 1:
		vel.x = 1
		$AnimatedSprite.animation = "walk"
		$AnimatedSprite.play()
	elif move_where == 2:
		vel.x = -1
		$AnimatedSprite.animation = "walk"
		$AnimatedSprite.play()
	elif move_where == 3:
		vel.y = 1
		$AnimatedSprite.animation = "walk"
		$AnimatedSprite.play()
	elif move_where == 4:
		vel.y = -1
		$AnimatedSprite.animation = "walk"
		$AnimatedSprite.play()
	else:
		vel =  Vector2()
		$AnimatedSprite.animation = "idle"
		$AnimatedSprite.play()
	vel = vel.normalized()
	move_and_slide(vel * speed)
	pass


func _on_Timer_timeout():
	move_where = randi()% 5
	var vel = Vector2()
	match move_where:
		0: emit_signal("idle")
		1: vel.x = 1
		2: vel.x = -1
		3: vel.y = 1
		4: vel.y = -1
	vel = vel.normalized()
	

func _on_Area2D_area_entered(area:Area2D):
	if area.name =="area2Dattack"  or area.name =="explosion" :
		if Global.weapon == 0 :
			slime_hp -= 2
		elif Global.weapon == 1 :
			slime_hp -= 5
		elif Global.weapon == 2 :
			slime_hp -= 3
		elif Global.weapon == 3 :
			slime_hp -= 3
		elif Global.weapon == 4 :
			slime_hp -= 4
		elif Global.weapon == 5 :
			slime_hp -= 8
		if slime_hp <= 0 :
			get_node("CollisionShape2D").disabled = true
			Global.slime_kill += 1
			Global.slimeamount -= 1
			queue_free()
