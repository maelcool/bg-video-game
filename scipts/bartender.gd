extends Node2D

var ui_label
func _ready():
	pass

func _process(delta):
	pass

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


func _on_interact_range_input_event(viewport, event, shape_idx):
	if event is InputEventMouse:
		if event.is_pressed():
			print("HZUI")
			$LorePanel.visible = true
