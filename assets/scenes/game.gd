extends Node2D

@onready var level_container = $World/Level  
@onready var fightOverlay = $GUI/Fight
@onready var hand = $GUI/Fight/Hand

func _ready():
	load_level("LevelChoser", "null")  
	Global.currentScenePath = Global.level_scenes["LevelChoser"]
	Global.currentSceneNumber = -1
	Global.game = self

func load_level(level_key: String, enemy: String):
	print("LOAD LEVEL CALLED with level key" + level_key)
	if Global.currentScenePath == Global.level_scenes[level_key]:
		return
	if Global.currentSceneInstance != null:
		Global.currentSceneInstance.queue_free()
		Global.currentSceneInstance = null
	if Global.level_scenes.has(level_key):
		var scene_resource = load(Global.level_scenes[level_key])
		Global.currentSceneInstance = scene_resource.instantiate()
		level_container.add_child(Global.currentSceneInstance)
		Global.currentScenePath = Global.level_scenes[level_key]
	else:
		push_error("Level not found: %s" % level_key)


func startFighting(enemy: String):
	print("H")
	Global.playerCards.append(Global.possiblePlayerCards.get("smallHealing"))
	Global.playerCards.append(Global.possiblePlayerCards.get("smallBurst"))
	Global.playerCards.append(Global.possiblePlayerCards.get("bigBurst"))
	Global.playerCards.append(Global.possiblePlayerCards.get("bigHealing"))
	Global.playerCards.append(Global.possiblePlayerCards.get("smallKnowledge"))
	Global.playerCards.append(Global.possiblePlayerCards.get("bigKnowledge"))
	Global.playerCards.append(Global.possiblePlayerCards.get("smallHealing"))
	Global.playerCards.append(Global.possiblePlayerCards.get("smallBurst"))
	Global.playerCards.append(Global.possiblePlayerCards.get("bigBurst"))
	Global.playerCards.append(Global.possiblePlayerCards.get("bigHealing"))
	Global.playerCards.append(Global.possiblePlayerCards.get("smallKnowledge"))
	Global.playerCards.append(Global.possiblePlayerCards.get("bigKnowledge"))
	Global.playerCards.append(Global.possiblePlayerCards.get("smallHealing"))
	Global.playerCards.append(Global.possiblePlayerCards.get("smallBurst"))
	Global.playerCards.append(Global.possiblePlayerCards.get("bigBurst"))
	Global.playerCards.append(Global.possiblePlayerCards.get("bigHealing"))
	Global.playerCards.append(Global.possiblePlayerCards.get("smallKnowledge"))
	Global.playerCards.append(Global.possiblePlayerCards.get("bigKnowledge"))
	fightOverlay.visible = true
	_setCards(5)


func _setCards(howManyCards:int):
	for i in range(howManyCards):
		hand.draw()
