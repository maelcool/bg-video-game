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
var playerCards: Array = ["res://assets/cards/cardRessources/witch/smallHealing.tres","res://assets/cards/cardRessources/witch/smallBurst.tres",
"res://assets/cards/cardRessources/witch/BigBurst.tres","res://assets/cards/cardRessources/witch/smallKnowledge.tres"]


var card1
var card2
var card3
var card4

signal coins_changed(value)
signal slept

func _ready():
	playerHealth = 100
	playerCoins = 50
	playerMana = 0

func changeCoins(value: int):
	playerCoins += value
	coins_changed.emit(playerCoins)

func playerHasSlept():
	emit_signal("slept")

func startFirstLevel():
	if Global.currentSceneInstance != null:
		print("UASD")
		Global.currentSceneInstance.queue_free()
		Global.currentSceneInstance = null
	var scene_resource = load("res://assets/scenes/Game.tscn")
	Global.currentSceneInstance = scene_resource.instantiate()
	Global.currentScenePath = "res://assets/scenes/Game.tscn"
	Global.currentSceneNumber = 1
	get_tree().change_scene_to_file("res://assets/scenes/Game.tscn")

func fightTriggered(enemy: Node2D):
	stopTime = true
	var fightCanvas = game.get_node("GUI/Fight")
	fightCanvas.visible = true
	isPlayerinFight = true
	_setCards(fightCanvas)


func _setCards(fightCanvas):
	var playerDeck = playerCards.duplicate()
	playerDeck.shuffle()
	var playerHand:Array = playerDeck.slice(0,min(3, playerDeck.size()))
	card1 = fightCanvas.get_child(1)
	card1.setCardFromPath(playerHand[0])
	card2 = fightCanvas.get_child(2)
	card2.setCardFromPath(playerHand[1])
	card3 = fightCanvas.get_child(3)
	card4 = fightCanvas.get_child(4)
