extends Node2D

@onready var tabContainer = $Menu/TabContainer
@onready var characterChoice = $CharacterChoice
@onready var characterInfo = $CharacterInfo
@onready var witchPanel = $CharacterInfo/Witch
@onready var knightPanel = $CharacterInfo/Knight

func _process(delta):
	pass

func _goToGame():
	Global.startFirstLevel()


func _on_leave_pressed():
	get_tree().quit()


func _on_knight_pressed():
	characterInfo.visible = true
	witchPanel.visible = false
	knightPanel.visible = true
	
func _on_witch_pressed():
	characterInfo.visible = true
	witchPanel.visible = true
	knightPanel.visible = false


func _on_go_to_characters_pressed():
	tabContainer.visible = false
	characterChoice.visible = true


func _on_start_witch_pressed():
	Global.playerCharacter = Global.playerCharacterArray[0]
	_goToGame()


func _on_start_knight_pressed():
	Global.playerCharacter = Global.playerCharacterArray[1]
	_goToGame()
