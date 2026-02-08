extends Node2D

@onready var door1 = $Door1
@onready var door2 = $Door2
@onready var door3 = $Door3

var ui_label

func _ready():
	pass

func _process(_delta):
	pass


func _on_area_2d_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouse:
		if event.is_pressed():
			print("Door Pressed")
			Global.load_level(-1, "null")
