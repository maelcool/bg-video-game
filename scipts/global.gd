extends Node2D

var playerHealth: int
var playerCoins: int
var playerMana: int
var currentScenePath: String
var currentSceneInstance: Node = null
var game
var isItNight: bool = false

signal coins_changed(value)

func _ready():
	playerHealth = 100
	playerCoins = 50
	playerMana = 0

func changeCoins(value: int):
	playerCoins += value
	coins_changed.emit(playerCoins)
