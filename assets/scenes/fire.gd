extends Node2D

var ui_label

func _ready():
	ui_label = $Intraction_Label

func _process(delta):
	if Input.is_action_just_pressed("Interact"):
		print("INTERACT")
		Global.playerHasSlept()


func display_Interaction(isVisible: bool):
	if ui_label != null:
		ui_label.visible = isVisible

func _on_area_2d_body_entered(body):
	if body is CharacterBody2D:
		display_Interaction(true) 

func _on_area_2d_body_exited(body):
	if body is CharacterBody2D:
		display_Interaction(false)
