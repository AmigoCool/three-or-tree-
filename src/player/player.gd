extends KinematicBody2D

var speed = 100
var attacktime = 0 
var health = 50
var backpack = 1
onready var Backpack = preload("res://src/player/backpack.tscn")
signal beattack
signal attack
signal attack2
signal closeBackpack

func _ready():
	$area2Dattack/attackarea.disabled = true
	
func _process(delta):
	Global.player_pos = get_global_position()
	var vel = Vector2()
	$Camera2D2/Label2.text = str(health) + "/50"
	#移動(包含動畫)
	if Input.is_action_pressed("ui_up") and attacktime != 1 :
		vel.y = -1
		$AnimatedSprite.animation = "up_walk"
		$AnimatedSprite.play()
	elif Input.is_action_pressed("ui_down") and attacktime != 1 :
		vel.y = 1
		$AnimatedSprite.animation = "down_walk"
		$AnimatedSprite.play()
	elif Input.is_action_pressed("ui_right") and attacktime != 1 :
		vel.x = 1
		$AnimatedSprite.animation = "side_walk"
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.play()
	elif Input.is_action_pressed("ui_left") and attacktime != 1 :
		vel.x = -1
		$AnimatedSprite.animation = "side_walk"
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play()
	else: #靜止時
			if attacktime != 1: #使攻擊時不會繼續play靜止動畫
				$AnimatedSprite.flip_h = false
				$AnimatedSprite.animation = "idle"
				$AnimatedSprite.play()
	#使移動均速
	vel = vel.normalized()
	move_and_slide(vel * speed)
	
	if Input.is_action_just_pressed("leftclick") and attacktime == 0: #攻擊
		var mouse_pos = get_global_mouse_position() 
		var player_pos = get_global_position()
		var attackwhere = rad2deg(mouse_pos.angle_to_point(player_pos))
		#print(player_pos) #debug用
		#print(mouse_pos)
		#print(attackwhere)
		if attackwhere <= 45 and attackwhere >= -45 : #右
			attackwhere = 0
			emit_signal("attack")
			$AnimatedSprite.animation = "sideattack"
			$AnimatedSprite.flip_h = true
			$AnimatedSprite.play()
			$area2Dattack/attackarea.disabled = false
			$area2Dattack/attackarea.position = Vector2(45,-37.5)
			$area2Dattack/attackarea.rotation_degrees = 90
		elif attackwhere <= -45 and attackwhere >= -135 : #上
			attackwhere = 0
			emit_signal("attack")
			$AnimatedSprite.animation = "upattack"
			$AnimatedSprite.play()
			$area2Dattack/attackarea.disabled = false
			$area2Dattack/attackarea.position = Vector2(0,-85)
			$area2Dattack/attackarea.rotation_degrees = 0
		elif attackwhere <= 135 and attackwhere >= 45 : #下
			attackwhere = 0
			emit_signal("attack")
			$AnimatedSprite.animation = "downattack"
			$AnimatedSprite.play()
			$area2Dattack/attackarea.disabled = false
			$area2Dattack/attackarea.position = Vector2(0,0)
			$area2Dattack/attackarea.rotation_degrees = 0
		else : #左
			attackwhere = 0
			emit_signal("attack")
			$AnimatedSprite.animation = "sideattack"
			$AnimatedSprite.play()
			$area2Dattack/attackarea.disabled = false
			$area2Dattack/attackarea.position = Vector2(-40,-37.5)
			$area2Dattack/attackarea.rotation_degrees = 90
			
	if Input.is_action_just_pressed("backpack"):
		Global.backpack = Global.backpack * -1
		if Global.backpack == -1:
			var openbackpack =  Backpack.instance()
			$Camera2D2.add_child(openbackpack)
			

func _on_KinematicBody2D_attack(): #使攻擊動畫只攻擊一次
	attacktime = 1
	if attacktime == 1 :
		emit_signal("attack2")
		yield(get_tree().create_timer(0.8), "timeout")
		attacktime = 0
		if  $AnimatedSprite.animation == "sideattack":
			$AnimatedSprite.stop()
			$area2Dattack/attackarea.disabled = true
		elif $AnimatedSprite.animation == "downattack":
			$AnimatedSprite.stop()
			$area2Dattack/attackarea.disabled = true
		elif $AnimatedSprite.animation == "upattack":
			$AnimatedSprite.stop()
			$area2Dattack/attackarea.disabled = true
	


#func _on_Node2D_body_entered(body:PhysicsBody2D,area):
#	if body.name == "slime":
#		minusHP(get_node("Area2D"), "slime")
#	elif body.name =="zombie":
#		minusHP(get_node("Area2D"), "zombie")
#	elif body.name =="flower":
#		minusHP(get_node("Area2D"), "flower")
		
func minusHP(PArea2D: Node2D, DamagedFrom: String) -> void:
	if DamagedFrom == "slime":
		$Node2D/CollisionShape2D.disabled = true
		emit_signal("beattack")
		health -= 2
	elif DamagedFrom == "zombie":
		$Node2D/CollisionShape2D.disabled = true
		emit_signal("beattack")
		health -= 10
	elif DamagedFrom == "flower" :
		$Node2D/CollisionShape2D.disabled = true
		emit_signal("beattack")
		health -= 5
	if(health <= 0):
		get_node("CollisionShape2D").disabled = true
		queue_free()
		get_tree().change_scene("res://src/died/died.tscn")


func _on_Node2D_area_entered(area:Area2D):
	if area.name == "slime":
		minusHP(get_node("Area2D"), "slime")
	elif area.name =="zombie":
		minusHP(get_node("Area2D"), "zombie")
	elif area.name =="flower":
		minusHP(get_node("Area2D"), "flower")




func _on_regenerate_timeout():
	if health <= 49:
		health += 1
	

func _on_KinematicBody2D_attack2():
	if attacktime == 1:
		$attack.play()
		yield(get_tree().create_timer(0.6), "timeout")
		$attack.stop()


func _on_KinematicBody2D_beattack():
	yield(get_tree().create_timer(0.25), "timeout")
	$Node2D/CollisionShape2D.disabled = false
