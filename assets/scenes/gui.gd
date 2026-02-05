extends Control

@onready var coinDisplay: RichTextLabel = $Display/DisplayCoins
@onready var askNight: RichTextLabel = $Display/AskNight
@onready var dayNightGradient = load("res://assets/Themes/dayNightGradient.tres")

func _ready():
	Global.coins_changed.connect(_on_coins_changed)
	_on_coins_changed(Global.playerCoins)

func _process(delta):
	pass



func _on_coins_changed(value):
	coinDisplay.text = "[img=16x16]res://assets/images/Coin.png[/img] Coins %d" % value
