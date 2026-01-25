extends Node2D

@onready var ui_label = $QuestPanel


func _on_interact_range_input_event(viewport, event, shape_idx):
	if event is InputEventMouse:
		if event.is_pressed():
			print("Quest shown")
			if ui_label.visible == false:
				ui_label.visible = true
			else:
				ui_label.visible = false
