extends Node

var weapon = 0 # 0是空手 1是劍 2是斧頭 3是稿子 4是弓 5是explosion
var slime_kill = 0
var zombie_kill = 0 
var flower_kill = 0
var survday = 0
var player_pos = Vector2()
var wood = 1000
var stone = 1000
var grass = 1000
var cwood = 0
var cstone = 0
var cgrass = 0
var backpack = 1
var volumeset = 1

var sword = 0 #0代表還沒做過 -1代表做了沒裝備 1代表裝備著
var axe = 0
var pickaxe = 0
var bow = 0
var explosion = 0

var house = -1 #-1代表還沒蓋 #1代表蓋了
var chest = -1
var boss = -1

var BGM = 0
var effect = 0 

var bhouse = 0
var bchest = 0
var bboss = 0

var inhouse = 0
var altaron = 0
var altarnear = 0

var zombieamount = 0 
var floweramount = 0 
var treeamount = 0 
var slimeamount = 0 
var stoneamount = 0 
var grassamount = 0 

var day = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
