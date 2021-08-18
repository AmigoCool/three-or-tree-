extends Node2D
var mode = 0 #預設是0 存是1 拿是-1
var woodchange = 0
var stonechange = 0
var grasschange = 0

func _ready():
	pass # Replace with function body.


func _process(delta):	
	if Global.chest == 1:
		queue_free()
	if mode == 1:
		$store.disabled = true
		$draw.disabled = false
		$woods2.text = str(Global.wood)
		$stone2.text = str(Global.stone)
		$grass2.text = str(Global.grass)
		$stone.max_value = Global.stone
		$woods.max_value = Global.wood
		$grass.max_value = Global.grass
	elif mode == -1 :
		$draw.disabled = true
		$store.disabled = false
		$woods2.text = str(Global.cwood)
		$stone2.text = str(Global.cstone)
		$grass2.text = str(Global.cgrass)
		$stone.max_value = Global.cstone
		$woods.max_value = Global.cwood
		$grass.max_value = Global.cgrass
	if woodchange == 0 :
		$woodok.disabled = true
	else:
		$woodok.disabled = false
	if stonechange == 0 :
		$stoneok.disabled = true
	else:
		$stoneok.disabled = false
	if grasschange == 0 :
		$grassok.disabled = true
	else:
		$grassok.disabled = false


func _on_store_pressed():
	mode = 1

func _on_draw_pressed():
	mode = -1


func _on_stone_value_changed(value):
	$stonevalue.text = str(value)
	stonechange = value


func _on_woods_value_changed(value):
	$woodsvalue.text = str(value)
	woodchange = value

func _on_grass_value_changed(value):
	$grassvalue.text = str(value)
	grasschange = value

func _on_woodok_pressed():
	if mode == 1:
		Global.wood = Global.wood - woodchange
		Global.cwood = Global.cwood + woodchange
		woodchange = 0
		$woods.value = 0
	elif mode == -1 :
		Global.cwood = Global.cwood - woodchange
		Global.wood = Global.wood + woodchange
		woodchange = 0 
		$woods.value = 0

func _on_stoneok_pressed():
	if mode == 1:
		Global.stone = Global.stone - stonechange
		Global.cstone = Global.cstone + stonechange
		stonechange = 0
		$stone.value = 0
	elif mode == -1 :
		Global.cstone = Global.cstone - stonechange
		Global.stone = Global.stone + stonechange
		stonechange = 0
		$stone.value = 0

func _on_grassok_pressed():
	if mode == 1:
		Global.grass = Global.grass - grasschange
		Global.cgrass = Global.cgrass + grasschange
		grasschange = 0
		$grass.value = 0
	elif mode == -1 :
		Global.cgrass = Global.cgrass - grasschange
		Global.grass = Global.grass + grasschange
		grasschange = 0
		$grass.value = 0


#func _on_TextureButton_pressed():
#	queue_free()
