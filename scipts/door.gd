extends Node2D

@onready var door1 = $Door1
@onready var door2 = $Door2
@onready var door3 = $Door3

var ui_label
signal next_level

func _ready():
	ui_label = $Intraction_Label

func _process(delta):
	if Input.is_action_just_pressed("Interact") and ui_label.visible == true:
		emit_signal("next_level")
	if Global.currentSceneNumber == 1:
		door1.visible = true
	elif  Global.currentSceneNumber == 2:
		print("UHGVSAD")
		door2.visible = true
	elif  Global.currentSceneNumber == 3:
		door2.visible = true


func display_Interaction(isVisible: bool):
	if ui_label != null:
		ui_label.visible = isVisible

func _on_area_2d_body_entered(body):
	if body is CharacterBody2D:
		display_Interaction(true) 

func _on_area_2d_body_exited(body):
	if body is CharacterBody2D:
		display_Interaction(false)
