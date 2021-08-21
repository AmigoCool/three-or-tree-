extends KinematicBody2D
var flower_hp = 20
var attack_where = 1
var attack_time = 1
var near = 0
signal right
signal left


func _ready():
	$Timer.start()
	$flower/CollisionShape2D.disabled = true
	pass

func _process(delta):
	$Camera2D/Label2.text = str(flower_hp) + "/20"
	if attack_time == 0 :
		$AnimatedSprite.animation = "idle"
		$flower/CollisionShape2D.disabled = true

func _on_Timer_timeout():
	attack_where = attack_where * -1
	match attack_where:
		1: emit_signal("left")
		-1: emit_signal("right")
	

func _on_Area2D_area_entered(area:Area2D):
	if area.name =="area2Dattack"  or area.name =="explosion" :
		if Global.weapon == 0 :
			flower_hp -= 2
		elif Global.weapon == 1 :
			flower_hp -= 5
		elif Global.weapon == 2 :
			flower_hp -= 3
		elif Global.weapon == 3 :
			flower_hp -= 3
		elif Global.weapon == 4 :
			flower_hp -= 4
		elif Global.weapon == 5 :
			flower_hp -= 8
		if flower_hp <= 0 :
			get_node("CollisionShape2D").disabled = true
			Global.flower_kill += 1
			Global.floweramount -= 1
			queue_free()


func _on_flower_left():
	if near == 1 :
		attack_time = 1
		$flower/CollisionShape2D.position = Vector2(-37,-25)
		$flower/CollisionShape2D.disabled = false
		$AnimatedSprite.animation = "atkleft"
		$AnimatedSprite.play()
		yield(get_tree().create_timer(2), "timeout")
		attack_time = 0

func _on_flower_right():
	if near == 1 :
		attack_time = 1 
		$flower/CollisionShape2D.position = Vector2(37,-25)
		$flower/CollisionShape2D.disabled = false
		$AnimatedSprite.animation = "atkright"
		$AnimatedSprite.play()
		yield(get_tree().create_timer(2), "timeout")
		attack_time = 0


func _on_Area2D2_body_entered(body):
	near = 1 


func _on_Area2D2_body_exited(body):
	near = 0
