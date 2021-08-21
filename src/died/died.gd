extends Node2D


func _ready():
	Global.weapon = 0 # 0是空手 1是劍 2是斧頭 3是稿子 4是弓 5是explosion
	Global.slime_kill = 0
	Global.zombie_kill = 0 
	Global.flower_kill = 0
	Global.survday = 0
	Global.player_pos = Vector2()
	Global.wood = 1000
	Global.stone = 1000
	Global.grass = 1000
	Global.cwood = 0
	Global.cstone = 0
	Global.cgrass = 0
	Global.backpack = 1
	Global.volumeset = 1

	Global.sword = 0 #0代表還沒做過 -1代表做了沒裝備 1代表裝備著
	Global.axe = 0
	Global.pickaxe = 0
	Global.bow = 0
	Global.explosion = 0

	Global.house = -1 #-1代表還沒蓋 #1代表蓋了
	Global.chest = -1
	Global.boss = -1

	Global.BGM = 0
	Global.effect = 0 

	Global.bhouse = 0
	Global.bchest = 0
	Global.bboss = 0

	Global.inhouse = 0
	Global.altaron = 0
	Global.altarnear = 0

	Global.zombieamount = 0 
	Global.floweramount = 0 
	Global.treeamount = 0 
	Global.slimeamount = 0 
	Global.stoneamount = 0 
	Global.grassamount = 0 

func _process(delta):
	$zombie.text = str(Global.zombie_kill) 
	$slime.text = str(Global.slime_kill) 
	$flower.text = str(Global.flower_kill) 

func _on_Button_pressed():
	get_tree().change_scene("res://src/main/Main.tscn")



func _on_Button2_pressed():
	get_tree().quit()
