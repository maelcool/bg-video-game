extends Node2D

var playerHealth: int
var playerCoins: int
var playerMana: int
var currentScenePath: String
var currentSceneInstance: Node = null
var currentSceneNumber: int = 0
var game
var stopTime: bool = false

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
