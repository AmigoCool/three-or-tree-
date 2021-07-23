extends KinematicBody2D
var hit_times = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_area_entered(area):
		if area.name =="area2Dattack":
			if Global.weapon == 0 :
				hit_times += 1
			elif Global.weapon == 1 :
				hit_times += 1
			elif Global.weapon == 2 :
				hit_times += 1
			elif Global.weapon == 3 :
				hit_times += 2
			if hit_times >= 10 :
				hit_times = -100
				get_node("CollisionShape2D").disabled = true
				Global.stone += 1
				$AnimatedSprite.animation = "breaked"
				$Camera2D/Label.text = "stones +1"
				$Area2D/CollisionShape2D.disabled = true
				yield(get_tree().create_timer(2.0), "timeout")
				queue_free()
