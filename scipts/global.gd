extends Node2D

var playerHealth: int
var playerCoins: int
var playerMana: int
var currentScenePath: String
var currentSceneInstance: Node = null
var currentSceneNumber: int = 0
var game: Node2D
var stopTime: bool = false
var isPlayerinFight: bool = false
var playerCharacter: String
var playerCharacterArray = ["Witch","Knight"]
var possiblePlayerCards: Dictionary ={
	"smallHealing": preload("res://assets/cards/cardRessources/witch/smallHealing.tres"),
	"bigHealing": preload("res://assets/cards/cardRessources/witch/bigHealing.tres"),
	"smallBurst": preload("res://assets/cards/cardRessources/witch/smallBurst.tres"),
	"bigBurst": preload("res://assets/cards/cardRessources/witch/BigBurst.tres"),
	"smallKnowledge": preload("res://assets/cards/cardRessources/witch/smallKnowledge.tres"),
	"bigKnowledge": preload("res://assets/cards/cardRessources/witch/bigKnowledge.tres")
}

var playerCards: Array[CardStats] = []

var level_scenes = {
	"Level1": "res://assets/scenes/level_1.tscn",
	"Level2": "res://assets/scenes/level_2.tscn",
	"Level3": "res://assets/scenes/level_3.tscn",
	"Night": "res://assets/scenes/night.tscn",
	"Witch": "res://assets/scenes/night.tscn",
	"Knight": "res://assets/scenes/night.tscn",
	"Bar": "res://assets/scenes/level_1.tscn",
	"Chest": "res://assets/scenes/night.tscn",
	"LevelChoser": "res://assets/scenes/level_choser.tscn",
	"Camp": "res://assets/scenes/night.tscn",
	"Mystery": "res://assets/scenes/night.tscn",
	"Goblin": "res://assets/scenes/night.tscn",
	"DragonBoss": "res://assets/scenes/night.tscn"
}


var card1
var card2
var card3
var card4

# ------------- Level Choser -------------
var roomTree: Array[RoomStats] = []
var treeGenerated: bool = false
var amountVisited = 0

signal coins_changed(value)
signal slept

func _ready():
	playerHealth = 100
	playerCoins = 50
	playerMana = 0

func load_level(level_key: int, enemy: String):
	print(level_key)
	currentSceneNumber = level_key
	print("CURRENT SCENE NUMEBR" +str(currentSceneNumber))
	if level_key == -1:
		currentScenePath = "LevelChoser"
		if game != null:
			game.load_level("LevelChoser", enemy)
	elif level_key == 0:
		currentScenePath = "Bar"
		if game != null:
			game.load_level("Bar", enemy)
	elif level_key == 1:
		currentScenePath = "Level2"
		game.startFighting(enemy)
		if game != null:
			game.load_level("Level2", enemy)
	elif level_key == 2 or level_key == 3:
		currentScenePath = "Level3"
		if game != null:
			game.load_level("Level3", enemy)
	else:
		printerr("LOAD LEVEL GLOBAL, NO VALID LEVEL KEY" + str(level_key))

func changeCoins(value: int):
	playerCoins += value
	coins_changed.emit(playerCoins)

func playerHasSlept():
	emit_signal("slept")

func startFirstLevel():
	if Global.currentSceneInstance != null:
		Global.currentSceneInstance.queue_free()
		Global.currentSceneInstance = null
	var scene_resource = load("res://assets/scenes/Game.tscn")
	Global.currentSceneInstance = scene_resource.instantiate()
	Global.currentScenePath = "res://assets/scenes/Game.tscn"
	Global.currentSceneNumber = 1
	get_tree().change_scene_to_file("res://assets/scenes/Game.tscn")
