extends KinematicBody2D

var speed = 100
var attacktime = 0 
var health = 50
var backpack = 1
var idle = 1
var bowcd = 1
var bowpos = Vector2()
#var inhouse = 0
var near = 0
var bhouse = 1
var bchest = 1
var baltar = 1
var altarnear = 0
onready var Backpack = preload("res://src/player/backpack.tscn")
onready var chest = preload("res://src/building/chest/cheset.tscn")
onready var volumeset = preload("res://src/player/volume_set.tscn")
onready var arrow = preload("res://src/player/bow/arrow.tscn")
signal beattack
signal attackdd
signal attack2
signal attack
signal closeBackpack
signal bowattack
signal bhouse
signal bchest
signal baltar
signal explosion

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
	#靜止時
	else: 
			if attacktime != 1 and bowcd == 1: #使攻擊時不會繼續play靜止動畫
				$AnimatedSprite.flip_h = false
				$AnimatedSprite.animation = "idle"
				$AnimatedSprite.play()
	#使移動均速
	vel = vel.normalized()
	move_and_slide(vel * speed)
	
	if Input.is_action_just_pressed("leftclick") and attacktime == 0 and idle == 1: #攻擊
		var mouse_pos = get_global_mouse_position() 
		var player_pos = get_global_position()
		var attackwhere = rad2deg(mouse_pos.angle_to_point(player_pos))
		#print(player_pos) #debug用
		#print(mouse_pos)
		#print(attackwhere)
		if attackwhere <= 45 and attackwhere >= -45 and Global.weapon == 4 : #弓右

			emit_signal("bowattack")
			$AnimatedSprite.animation = "bowside"
			$AnimatedSprite.flip_h = true
			$AnimatedSprite.play()
		elif attackwhere <= -45 and attackwhere >= -135 and Global.weapon == 4 : #弓上

			emit_signal("bowattack")
			$AnimatedSprite.animation = "bowup"
			$AnimatedSprite.play()
		elif attackwhere <= 135 and attackwhere >= 45 and Global.weapon == 4 : #弓下

			emit_signal("bowattack")
			$AnimatedSprite.animation = "bowdown"
			$AnimatedSprite.play()
		elif Global.weapon == 4 : #弓左

			emit_signal("bowattack")
			$AnimatedSprite.animation = "bowside"
			$AnimatedSprite.play()


		if attackwhere <= 45 and attackwhere >= -45 and Global.weapon != 4 and Global.weapon != 5 : #右
			attackwhere = 0
			emit_signal("attack")
			$AnimatedSprite.animation = "sideattack"
			$AnimatedSprite.flip_h = true
			$AnimatedSprite.play()
			$area2Dattack/attackarea.disabled = false
			$area2Dattack/attackarea.position = Vector2(45,-37.5)
			$area2Dattack/attackarea.rotation_degrees = 90
		elif attackwhere <= -45 and attackwhere >= -135 and Global.weapon != 4 and Global.weapon != 5 : #上
			attackwhere = 0
			emit_signal("attack")
			$AnimatedSprite.animation = "upattack"
			$AnimatedSprite.play()
			$area2Dattack/attackarea.disabled = false
			$area2Dattack/attackarea.position = Vector2(0,-85)
			$area2Dattack/attackarea.rotation_degrees = 0
		elif attackwhere <= 135 and attackwhere >= 45 and Global.weapon != 4 and Global.weapon != 5: #下
			attackwhere = 0
			emit_signal("attack")
			$AnimatedSprite.animation = "downattack"
			$AnimatedSprite.play()
			$area2Dattack/attackarea.disabled = false
			$area2Dattack/attackarea.position = Vector2(0,0)
			$area2Dattack/attackarea.rotation_degrees = 0
		elif Global.weapon != 4 and Global.weapon != 5 : #左
			attackwhere = 0
			emit_signal("attack")
			$AnimatedSprite.animation = "sideattack"
			$AnimatedSprite.play()
			$area2Dattack/attackarea.disabled = false
			$area2Dattack/attackarea.position = Vector2(-40,-37.5)
			$area2Dattack/attackarea.rotation_degrees = 90
		elif Global.weapon == 5 :
			$explosion/attackarea.disabled = false
			$AnimatedSprite.animation = ("explosion")
			emit_signal("attack")

	if Input.is_action_just_pressed("backpack") : #開背包
		Global.backpack = Global.backpack * -1
		idle = idle * -1
		if Global.backpack == -1 :
			var openbackpack =  Backpack.instance()
			$Camera2D2.add_child(openbackpack)

	if Input.is_action_just_pressed("rightclick") and near == 1 : #開關箱子
		Global.chest = Global.chest * -1
		idle = idle * -1
		attacktime =  attacktime * -1
		if Global.chest == -1 :
			var openchest = chest.instance()
			$Camera2D2.add_child(openchest)
		


	if Global.bhouse == 1 :
		Global.backpack = Global.backpack * -1
		idle = 0
		$house.show()
		$house.position = get_local_mouse_position()
		if Input.is_action_just_pressed("rightclick"):
			idle = 1
			$house.hide()
			Global.bhouse = 0
			emit_signal("bhouse")
	if Global.bchest == 1 :
		Global.backpack = Global.backpack * -1
		idle = 0
		$chest.show()
		$chest.position = get_local_mouse_position()
		if Input.is_action_just_pressed("rightclick"):
			idle = 1
			$chest.hide()
			Global.bchest = 0
			emit_signal("bchest")
	if Global.bboss == 1 :
		Global.backpack = Global.backpack * -1
		idle = 0
		$altar.show()
		$altar.position = get_local_mouse_position()
		if Input.is_action_just_pressed("rightclick"):
			idle = 1
			$altar.hide()
			Global.bboss = 0
			emit_signal("baltar")
	if Global.altarnear == 1 and Input.is_action_just_pressed("rightclick"):
		Global.altaron = 1

func _on_KinematicBody2D_attack(): #使攻擊動畫只攻擊一次
	attacktime = 1
	if attacktime == 1 and idle == 1 :
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
		elif $AnimatedSprite.animation == "explosion" :
			$AnimatedSprite.stop()
			$explosion/attackarea.disabled = true

func minusHP(DamagedFrom: String) -> void: #扣血
	if DamagedFrom == "slime":
		$Node2D/CollisionShape2D.position = Vector2(9999,9999)
		emit_signal("beattack")
		health -= 2
	elif DamagedFrom == "zombie":
		$Node2D/CollisionShape2D.position = Vector2(9999,9999)
		emit_signal("beattack")
		health -= 10
	elif DamagedFrom == "flower" :
		$Node2D/CollisionShape2D.position = Vector2(9999,9999)
		emit_signal("beattack")
		health -= 5
	if(health <= 0):
		get_node("CollisionShape2D").disabled = true
		queue_free()
		get_tree().change_scene("res://src/died/died.tscn")


func _on_Node2D_area_entered(area:Area2D): #判定被誰打
	if area.name == "slime":
		minusHP("slime")
	elif area.name =="zombie":
		minusHP("zombie")
	elif area.name =="flower":
		minusHP("flower")

func _on_regenerate_timeout(): #每秒回血
	if health <= 49:
		health += 1

func _on_KinematicBody2D_attack2(): #攻擊音效
	if attacktime == 1:
		if Global.weapon == 4:
			pass
		else:
			$attack.play()
			yield(get_tree().create_timer(0.6), "timeout")
			$attack.stop()
	if bowcd == 1 and Global.weapon == 4 :
		$bow2.play()
		yield(get_tree().create_timer(0.3), "timeout")
		$bow2.stop()

func _on_KinematicBody2D_beattack(): #被打音效 碰撞箱
	hurtsound()
	yield(get_tree().create_timer(1), "timeout")
	$Node2D/CollisionShape2D.position = Vector2(0,-37)

func hurtsound():
	$hurt.play()
	yield(get_tree().create_timer(0.3), "timeout")
	$hurt.stop()

func _on_TextureButton_pressed(): #設定
	Global.volumeset = Global.volumeset * -1
	if Global.volumeset == -1:
		var openvolumeset =  volumeset.instance()
		$Camera2D2.add_child(openvolumeset)
		get_tree().paused = true

func _on_KinematicBody2D_bowattack(): #拿弓攻擊時
	var mouse_pos = get_global_mouse_position()  
	var player_pos = $AnimatedSprite.global_position
	var arrowrotation = rad2deg(mouse_pos.angle_to_point(player_pos)) + 90
	var bowpos = get_local_mouse_position()
	if bowcd == 1 :
		emit_signal("attack2")
		$bow.start()
		var Arrow = arrow.instance()
		get_node("/root/Main").add_child(Arrow)
		Arrow.position = player_pos
		Arrow.rotation_degrees = arrowrotation
		print(arrowrotation)
		Arrow.apply_central_impulse(bowpos)
		bowcd = -1

func _on_bow_timeout():
	bowcd = 1

func _on_inventory_boss():
	Global.backpack = Global.backpack * -1
	if Input.is_action_just_pressed("leftclick"):
		idle = 1

func _on_inventory_chest():
	Global.backpack = Global.backpack * -1
	if Input.is_action_just_pressed("leftclick"):
		idle = 1

func _on_Area2D_body_entered(body):
	Global.inhouse = 1

func _on_Area2D_body_exited(body):
	Global.inhouse = 0

func _on_Node2D_goin():
	global_position = Vector2(12000,8900)

func _on_StaticBody2D_near():
	near = 1

func _on_StaticBody2D_out():
	Global.chest = 1
	Global.backpack = 1
	idle = 1
	attacktime = 0
	near = 0

func _on_boss_win():
	get_tree().change_scene("res://src/win/win.tscn")

func _on_KinematicBody2D_explosion(): #explosion攻擊時
	$explosion/attackarea.disabled = false
	$AnimatedSprite.animation = ("explosion")
	emit_signal("attack")
