extends CanvasModulate
var time = 35
signal night
signal day

func _ready():
	pass

func _process(delta):
	var currentframe = range_lerp(time,0,120,0,24)
	#print(currentframe)
	$AnimationPlayer.play("day_night")
	$AnimationPlayer.seek(currentframe,true)

func _on_daynight_timeout():
	#print(time)
	time += 1
	if time >= 120:
		time = 0
	if time >= 95 :
		emit_signal("night")
	elif time <= 30 :
		emit_signal("night")
	else:
		emit_signal("day")


