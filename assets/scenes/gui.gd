extends Control

@onready var coinDisplay: RichTextLabel = $Display/DisplayCoins
@onready var timeDisplay: RichTextLabel = $Display/Time
@onready var askNight: RichTextLabel = $Display/AskNight
@onready var dayNightOverlay: CanvasModulate = $"../DayNightOverlay"
@onready var dayNightGradient = load("res://dayNightGradient.tres")

@export var cycle_speed := 0.01

var time_of_day := 8.0 / 24

signal night_emitted
var night_sent := false

func _ready():
	Global.coins_changed.connect(_on_coins_changed)
	_on_coins_changed(Global.playerCoins)

func _process(delta):
	if Global.stopTime:
		return

	time_of_day = fmod(time_of_day + cycle_speed * delta, 1.0)
	if !Global.stopTime:
		setTime()
		update_day_night()
		check_night_event()

# -------------------------
# DAY / NIGHT LOGIC
# -------------------------

func update_day_night():
	var hour := time_of_day * 24.0
	var gradient_value := 0.0

	if hour < 8.0:
		# 🌅 Sunrise (0 → 1)
		gradient_value = hour / 8.0
	elif hour < 20.0:
		# ☀️ Day (stay bright)
		gradient_value = 1.0
	else:
		# 🌙 Sunset / Night (1 → 0)
		gradient_value = 1.0 - ((hour - 20.0) / 4.0)

	dayNightOverlay.color = dayNightGradient.sample(gradient_value)

# -------------------------
# NIGHT EVENT
# -------------------------

func check_night_event():
	var hour := time_of_day * 24.0

	if hour >= 23.9 and not night_sent:
		print("NIGHT")
		night_sent = true
		emit_signal("night_emitted")
		askNight.visible = false
		Global.stopTime = true
		time_of_day = 1.00 
		setTime()

	elif hour >= 22.0 and night_sent:
		night_sent = false
		askNight.visible = true

# -------------------------
# UI
# -------------------------

func setTime():
	var total_hours := time_of_day * 24.0
	var hours := int(total_hours)
	var minutes := int((total_hours - hours) * 60)
	timeDisplay.text = "Time %02d:%02d" % [hours, minutes]

func _on_coins_changed(value):
	coinDisplay.text = "[img=16x16]res://assets/images/Coin.png[/img] Coins %d" % value
