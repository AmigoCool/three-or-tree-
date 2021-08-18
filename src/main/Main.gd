extends Node2D
var tree = preload("res://src/resources/tree/tree.tscn")
var stone = preload("res://src/resources/stone/stone.tscn")
var grass = preload("res://src/resources/grass/grass.tscn")
var zombie = preload("res://src/mob/mob2/zombie.tscn")
var flower = preload("res://src/mob/mob3/flower.tscn")
var slime = preload("res://src/mob/mob3/flower.tscn")
var day = 1
var rand = RandomNumberGenerator.new()
var zombieamount = 0 



# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(0,30):
		var stonee = stone.instance()
		rand.randomize()
		var x = rand.randf_range(-1500,1500)
		rand.randomize()
		var y = rand.randf_range(-1500,1500)
		stonee.position.x = x
		stonee.position.y = y
		add_child(stonee)
	for i in range(0,30):
		var grasss = grass.instance()
		rand.randomize()
		var x = rand.randf_range(-1500,1500)
		rand.randomize()
		var y = rand.randf_range(-1500,1500)
		grasss.position.x = x
		grasss.position.y = y
		add_child(grasss)
	for i in range(0,30):
		var slimee = slime.instance()
		rand.randomize()
		var x = rand.randf_range(-1500,1500)
		rand.randomize()
		var y = rand.randf_range(-1500,1500)
		slimee.position.x = x
		slimee.position.y = y
		add_child(slimee)
	for i in range(0,30):
		var flowerr = flower.instance()
		rand.randomize()
		var x = rand.randf_range(-1500,1500)
		rand.randomize()
		var y = rand.randf_range(-1500,1500)
		flowerr.position.x = x
		flowerr.position.y = y
		add_child(flowerr)

func _process(delta):
	pass

func _on_CanvasModulate_day():
	day = 1


func _on_CanvasModulate_night():
	if zombieamount <= 30 :
		var zombiee = zombie.instance()
		rand.randomize()
		var x = rand.randf_range(-1500,1500)
		rand.randomize()
		var y = rand.randf_range(-1500,1500)
		zombiee.position.x = x
		zombiee.position.y = y
		add_child(zombiee)


func _on_player_baltar():
	$boss.position = get_global_mouse_position()


func _on_player_bhouse():
	$house.position = get_global_mouse_position()


func _on_player_bchest():
	$chest.position = get_global_mouse_position()


func _on_leavehouse_body_entered(body):
	$player.position.x = $house.position.x
	if $house.position.y >= 0 :
		$player.position.y = $house.position.y - 310
	else :
		$player.position.y = $house.position.y + 310
