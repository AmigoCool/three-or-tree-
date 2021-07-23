extends Node2D


func _ready():
	pass # Replace with function body.

func _process(delta):
	$zombie.text = str(Global.zombie_kill) 
	$slime.text = str(Global.slime_kill) 
	$wtf.text = str(Global.flower_kill) 

func _on_Button_pressed():
	get_tree().change_scene("res://src/main/Main.tscn")



func _on_Button2_pressed():
	get_tree().quit()
