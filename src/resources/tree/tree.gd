extends KinematicBody2D
var hit_times = 0
var tools

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
				tools = 1
			elif Global.weapon == 1 :
				hit_times += 1
				tools = 1
			elif Global.weapon == 2 :
				hit_times += 2
				tools = 3
			elif Global.weapon == 3 :
				hit_times += 1
				tools = 1
			if hit_times >= 5 :
				hit_times = -100
				get_node("CollisionShape2D").disabled = true
				Global.wood += tools
				$AnimatedSprite.animation = "stump"
				$Camera2D/Label.text = "Woods" + "+" + str(tools)
				$Area2D/CollisionShape2D.disabled = true
				yield(get_tree().create_timer(2.0), "timeout")
				Global.treeamount -= 1
				queue_free()
