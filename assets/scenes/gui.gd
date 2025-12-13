extends Control

@onready var coinDisplay: RichTextLabel = $Display/DisplayCoins
@onready var timeDisplay: RichTextLabel = $Display/Time
@onready var dayNightOverlay: CanvasModulate = $"../DayNightOverlay"
@onready var askNight: RichTextLabel = $Display/AskNight
@onready var dayNightGradient = load("res://dayNightGradient.tres")

@export var cycle_speed = 0.05
@export var max_darkness = 0.6 
@export var overlay_color: Color = Color(0.06, 0.072, 0.397)
@export var gradient: GradientTexture1D 

var time_of_day = 0.5

signal night

func _ready():
	Global.coins_changed.connect(_on_coins_changed)
	_on_coins_changed(Global.playerCoins)
	dayNightOverlay.color = overlay_color

func _process(delta):
	setTime()
	if !Global.isItNight:
		time_of_day += cycle_speed * delta 
		time_of_day = fmod(time_of_day, 1.0)
		calculateOverlay()
		if time_of_day > 1.0:
			print("Emiteted Night")
			emit_signal("night")
			askNight.visible = false
			Global.isItNight = true
		elif time_of_day >  0.95:
			askNight.visible = true

func _on_coins_changed(value):
	coinDisplay.text = "[img=16x16]res://assets/images/Coin.png[/img]Coins %d" % value

func calculateOverlay():
	dayNightOverlay.color = dayNightGradient.sample(time_of_day)

func setTime():
	var total_hours = time_of_day * 12
	var hours = int(total_hours) 
	var minutes = int((total_hours - hours) * 60)
	timeDisplay.text = "Time %02d:%02d" % [hours, minutes]
