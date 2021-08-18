extends StaticBody2D
signal near
signal out
signal win
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.altaron == 1:
		$AnimatedSprite.animation = ("used")
		$win/CollisionShape2D.disabled = false

func _on_Area2D_body_entered(body):
	Global.altarnear = 1


func _on_Area2D_body_exited(body):
	Global.altarnear = 0

func _on_win_body_entered(body):
	get_tree().change_scene("res://src/win/win.tscn")

