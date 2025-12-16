extends Node2D

@export var card: Card
@export var expandSize: float = 1.01

@onready var sprite2D: Sprite2D = $image

var tween_hover: Tween

func _ready():
	if card != null:
		_changeImage()
		if card.id == "0": 
			sprite2D.scale = Vector2(1,1)
	else:
		print("CARD IS null")

func setCardFromPath(newCard: String):
	card = load(newCard)
	_changeImage()

func _changeImage():
	sprite2D.texture = card.image

func _on_area_2d_mouse_entered():
	print("ENTERED")
	if tween_hover and tween_hover.is_running():
		tween_hover.kill()
	tween_hover = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	tween_hover.tween_property(self, "scale", Vector2(expandSize, expandSize), 0.5)


func _on_area_2d_mouse_exited():
	if tween_hover and tween_hover.is_running():
		tween_hover.kill()
	tween_hover = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	tween_hover.tween_property(self, "scale", Vector2.ONE, 0.55)
