extends CanvasModulate
var time = 25
signal night
signal day

func _ready():
	pass # Replace with function body.

func _process(delta):
	var currentframe = range_lerp(time,0,72,0,24)
	#print(currentframe)
	$AnimationPlayer.play("day_night")
	$AnimationPlayer.seek(currentframe,true)

func _on_daynight_timeout():
	#print(time)
	time += 1
	if time >= 72:
		time = 0
	if time >= 54 :
		emit_signal("night")
	elif time <= 24 :
		emit_signal("night")
	else:
		emit_signal("day")


