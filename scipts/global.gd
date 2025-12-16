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
	print("HA")
	stopTime = true
	game.get_node("GUI/Fight").visible = true
	isPlayerinFight = true
