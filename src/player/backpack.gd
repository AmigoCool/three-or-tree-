extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if Global.backpack == 1:
		queue_free()
	$woods.text = str(Global.wood) 
	$stone.text = str(Global.stone) 
	$grass.text = str(Global.grass) 

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
