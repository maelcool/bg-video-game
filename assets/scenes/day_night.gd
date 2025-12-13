extends Node2D

@export var cycle_speed = 0.01 
@export var max_darkness = 0.7 
@export var day_color: Color = Color(0.5, 0.8, 1.0)   
@export var night_color: Color = Color(0.112, 0.062, 0.353)
@export var overlay_color: Color = Color(0, 0, 0.212)

var time_of_day = 0.0

func _ready():
	$CanvasLayer/Overlay.color = overlay_color

func _process(delta):
	time_of_day += cycle_speed * delta 
	time_of_day = fmod(time_of_day, 1.0)
	calculateBackground()
	calculateOverlay()

func calculateOverlay():
	var darkness = sin(time_of_day * PI * 2) * max_darkness
	darkness = clamp(darkness, 0.0, max_darkness)
	$CanvasLayer/Overlay.color.a = darkness

func calculateBackground():
	var t = (sin(time_of_day * PI * 2) + 1) / 2  # Normalize sin output from 0 to 1
	$Background.color = day_color.lerp(night_color, t)
