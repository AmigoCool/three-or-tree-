extends Node2D
var tree = preload("res://src/resources/tree/tree.tscn")
var stone = preload("res://src/resources/stone/stone.tscn")
var grass = preload("res://src/resources/grass/grass.tscn")
var zombie = preload("res://src/mob/mob2/zombie.tscn")
var flower = preload("res://src/mob/mob3/flower.tscn")
var slime = preload("res://src/mob/mob3/flower.tscn")
var day = 1
var rand = RandomNumberGenerator.new()
var randm = RandomNumberGenerator.new()
var x = Vector2()
var y = Vector2()
var overlap = 0 #是沒重疊 1是有
var summon = 0 #0是不能生 1是能生
signal overlaping

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#for i in range(0,30):
	#	var stonee = stone.instance()
	#	rand.randomize()
	#	var x = rand.randf_range(-1500,1500)
	#	rand.randomize()
	#	var y = rand.randf_range(-1500,1500)
	#	stonee.position.x = x
	#	stonee.position.y = y
	#	add_child(stonee)
	#for i in range(0,30):
	#	var grasss = grass.instance()
	#	rand.randomize()
	#	var x = rand.randf_range(-1500,1500)
	#	rand.randomize()
	#	var y = rand.randf_range(-1500,1500)
	#	grasss.position.x = x
	#	grasss.position.y = y
	#	add_child(grasss)
	#for i in range(0,30):
	#	var slimee = slime.instance()
	#	rand.randomize()
	#	var x = rand.randf_range(-1500,1500)
	#	rand.randomize()
	#	var y = rand.randf_range(-1500,1500)
	#	slimee.position.x = x
	#	slimee.position.y = y
	#	add_child(slimee)
	#for i in range(0,30):
	#	var flowerr = flower.instance()
	#	rand.randomize()
	#	var x = rand.randf_range(-1500,1500)
	#	rand.randomize()
	#	var y = rand.randf_range(-1500,1500)
	#	flowerr.position.x = x
	#	flowerr.position.y = y
	#	add_child(flowerr)


	
func _process(delta):
	if Global.stoneamount < 30 : 
		overlapcheck()
		if summon == 1 :
			summonstone()
			Global.stoneamount += 1
			summon = 0 
	if Global.grassamount < 30 :
		overlapcheck()
		if summon == 1 :
			summongrass()
			Global.grassamount += 1
			summon = 0 
	if Global.treeamount <30 :
		overlapcheck()
		if summon == 1 :
			summonwood()
			Global.treeamount += 1
			summon = 0 
	if Global.slimeamount <30 :
		overlapcheck()
		if summon == 1 :
			summonslime()
			Global.slimeamount += 1
			summon = 0 
	if Global.floweramount <20 :
		overlapcheck()
		if summon == 1 :
			summonflower()
			Global.floweramount += 1
			summon = 0 
	if Global.zombieamount < 20 and day == 0:
		overlapcheck()
		if summon == 1 :
			summonzombie()
			Global.zombieamount += 1
			summon = 0 

func _on_CanvasModulate_day():
	day = 1


func _on_CanvasModulate_night():
#	if zombieamount <= 30 :
#		var zombiee = zombie.instance()
#		rand.randomize()
#		var x = rand.randf_range(-1500,1500)
#		rand.randomize()
#		var y = rand.randf_range(-1500,1500)
#		zombiee.position.x = x
#		zombiee.position.y = y
#		add_child(zombiee)
	day = 0

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

func overlapcheck():
	randm.randomize()
	x = randm.randf_range(-1500,1500)
	randm.randomize()
	y = randm.randf_range(-1500,1500)
	$overlap.position.x = x
	$overlap.position.y = y
	if overlap == 1 and summon == 0:
		emit_signal("overlaping")
		summon = 0
	else:
		summon = 1

func summonstone():
	var stonee = stone.instance()
	stonee.position.x = x
	stonee.position.y = y
	add_child(stonee)
	
func summongrass():
	var grasss = grass.instance()
	grasss.position.x = x
	grasss.position.y = y
	add_child(grasss)
	
func summonwood():
	var woodd = tree.instance()
	woodd.position.x = x
	woodd.position.y = y
	add_child(woodd)
	
func summonzombie():
	var zombiee = zombie.instance()
	zombiee.position.x = x
	zombiee.position.y = y
	add_child(zombiee)
	
func summonslime():
	var slimee = slime.instance()
	slimee.position.x = x
	slimee.position.y = y
	add_child(slimee)
	
func summonflower():
	var flowerr = flower.instance()
	flowerr.position.x = x
	flowerr.position.y = y
	add_child(flowerr)

func _on_Main_overlaping():
	overlapcheck()


func _on_overlap_body_entered(body):
	overlap = 1

	
