extends KinematicBody2D
var health = 50
var speed = 35
var attacked = 0
var night = 0
var day = 0
signal attacked

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	$Camera2D/Label2.text = str(health) + "/50"
	var direction = (Global.player_pos - get_global_position()).normalized()
	var walkwhere = rad2deg(get_global_position().angle_to_point(Global.player_pos))
	if attacked == 0 and night == 1:
		move_and_slide(direction*speed) 
		if walkwhere <= 45 and walkwhere >= -45 : #左
			$AnimatedSprite.animation = "left"
			$AnimatedSprite.play()
		elif walkwhere <= -45 and walkwhere >= -135 : #下
			$AnimatedSprite.animation = "down"
			$AnimatedSprite.play()
		elif walkwhere <= 135 and walkwhere >= 45 : #上
			$AnimatedSprite.animation = "up"
			$AnimatedSprite.play()
		else : #右
			$AnimatedSprite.animation = "right"
			$AnimatedSprite.play()
	if day == 1:
		$AnimatedSprite.animation = "idle"
		$AnimatedSprite.play()

func _on_Area2D_area_entered(area:Area2D):
	if area.name =="area2Dattack":
		emit_signal("attacked")
		if Global.weapon == 0 :
			health -= 2
		elif Global.weapon == 1 :
			health -= 5
		elif Global.weapon == 2 :
			health -= 3
		elif Global.weapon == 3 :
			health -= 3
		if health <= 0 :
			get_node("CollisionShape2D").disabled = true
			Global.zombie_kill += 1
			queue_free()


func _on_zombie_attacked():
	attacked = 1
	yield(get_tree().create_timer(0.2), "timeout")
	attacked = 0
	


func _on_CanvasModulate_day():
	day = 1
	night = 0


func _on_CanvasModulate_night():
	night = 1
	day = 0
