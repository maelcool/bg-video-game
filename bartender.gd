extends Node2D

var ui_label
func _ready():
	ui_label = $"Interact-Range/Intraction_Label"

func _process(delta):
	if Input.is_action_just_pressed("Interact"):
		if $"Interact-Range/Intraction_Label".visible == true:
			display_Interaction(false)
			$LorePanel.visible = true


func display_Interaction(hideOrShow):
	if ui_label != null:
		ui_label.visible = hideOrShow


func _on_interact_range_body_entered(body):
	if body is CharacterBody2D:
		display_Interaction(true) 

func _on_interact_range_body_exited(body):
	if body is CharacterBody2D:
		display_Interaction(false)
		$LorePanel.visible = false
