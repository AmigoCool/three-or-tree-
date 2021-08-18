extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$HSlider.value = Global.BGM
	$HSlider2.value = Global.effect
	
func _process(delta):
	print(Global.BGM)
	print(Global.effect)
	pass


func _on_TextureButton_pressed():
	get_tree().paused = false
	queue_free()


func _on_HSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("BGM"), value)
	Global.BGM = value


func _on_HSlider2_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("effect"), value)
	Global.effect = value
