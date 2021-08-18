extends Node2D
signal house
signal chest
signal boss

func _ready():
	pass # Replace with function body.

func _process(delta):
	$woods.text = str(Global.wood) 
	$stone.text = str(Global.stone) 
	$grass.text = str(Global.grass) 
	if Global.backpack == 1:
		queue_free()

	
	if Global.stone >= 10 and Global.wood >= 5 and Global.grass >=5 and Global.sword == 0 :
		$sword.disabled = false
	else:
		$sword.disabled = true
	if Global.stone >= 10 and Global.wood >= 5 and Global.grass >=5 and Global.axe == 0 :
		$axe.disabled = false
	else:
		$axe.disabled = true
	if Global.stone >= 10 and Global.wood >= 5 and Global.grass >=5 and Global.pickaxe == 0 :
		$pickaxe.disabled = false
	else:
		$pickaxe.disabled = true
	if Global.wood >= 15 and Global.grass >=10 and Global.bow == 0 :
		$bow.disabled = false
	else:
		$bow.disabled = true
	if Global.sword == -1 :
		$sworde.disabled = false
	else:
		$sworde.disabled = true
	if Global.axe == -1 :
		$Axee.disabled = false
	else:
		$Axee.disabled = true
	if Global.pickaxe == -1 :
		$pickaxee.disabled = false
	else:
		$pickaxee.disabled = true
	if Global.bow == -1 :
		$bowe.disabled = false
	else:
		$bowe.disabled = true

	if Global.stone >= 20 and Global.wood >= 20 and Global.grass >= 20 and Global.house == -1  :
		$house.disabled = false
	else:
		$house.disabled = true
	if Global.wood >= 20 and Global.grass >= 10 and Global.chest == -1 and Global.house == 1 and Global.inhouse == 1 :
		$chest.disabled = false
	else:
		$chest.disabled = true
	if Global.stone >= 50 and Global.wood >= 50 and Global.grass >= 50 and Global.boss == -1 and Global.house == 1 and Global.chest == 1 :
		$boss.disabled = false
	else:
		$boss.disabled = true


func _on_sword_pressed():
	Global.sword = -1
	Global.stone -= 10
	Global.wood -= 5
	Global.grass -=5


func _on_axe_pressed():
	Global.stone -= 10
	Global.wood -= 5
	Global.grass -=5 
	Global.axe = -1 


func _on_pickaxe_pressed():
	Global.stone -= 10
	Global.wood -= 5
	Global.grass -=5 
	Global.pickaxe = -1


func _on_bow_pressed():
	Global.wood -= 15
	Global.grass -= 10 
	Global.bow = -1


func _on_house_pressed():
	Global.stone -= 20
	Global.wood -= 20
	Global.grass -= 20
	Global.house = 1
	emit_signal("house")
	Global.bhouse = 1

func _on_chest_pressed():
	Global.wood -= 20
	Global.grass -= 10
	Global.chest = 1
	emit_signal("chest")
	Global.bchest = 1

func _on_boss_pressed():
	Global.stone -= 50
	Global.wood -= 50
	Global.grass -= 50
	emit_signal("boss")
	Global.bboss = 1


func _on_sworde_pressed():
	if Global.sword == -1 :
		Global.weapon = 1
		Global.sword = 1
		if Global.axe != 0:
			Global.axe = -1
		if Global.pickaxe != 0 :
			Global.pickaxe = -1
		if Global.bow != 0 :
			Global.bow = -1


func _on_Axee_pressed():
	if Global.axe == -1 :
		Global.weapon = 2
		if Global.sword != 0:
			Global.sword = -1 
		if Global.pickaxe != 0:
			Global.pickaxe = -1
		if Global.bow != 0 :
			Global.bow = -1
		Global.axe = 1



func _on_pickaxee_pressed():
	if Global.pickaxe == -1 :
		Global.weapon = 3
		if Global.sword != 0:
			Global.sword = -1 
		if Global.axe != 0:
			Global.axe = -1
		if Global.bow != 0 :
			Global.bow = -1
		Global.pickaxe = 1



func _on_bowe_pressed():
	if Global.bow == -1 :
		Global.weapon = 4
		if Global.sword != 0:
			Global.sword = -1 
		if Global.axe != 0:
			Global.axe = -1
		if Global.pickaxe != 0 :
			Global.pickaxe = -1
		Global.bow = 1



