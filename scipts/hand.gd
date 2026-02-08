extends ColorRect

const CARD = preload("res://assets/scenes/card.tscn")
const CARDSIZE:float = 37.5

@export var handCurve: Curve
@export var rotationCurve: Curve 

@export var maxRotationDegrees: int = 5
@export var xSep: float = -10
@export var yMin: int = 0
@export var yMax: int = -15

func draw():
	var newCard = CARD.instantiate()
	var cardPick = Global.playerCards.pick_random()
	newCard.card = cardPick
	Global.playerCards.erase(cardPick)
	add_child(newCard)
	_updateCards()

func removeCard():
	if get_child_count() < 1:
		return
	var child = get_child(-1)
	child.reparent(get_tree().root)
	child.queue_free()
	_updateCards()

func _updateCards():
	var cards = get_child_count()
	var allCardsSize = CARDSIZE *cards + xSep * (cards-1)
	var finalXSep = xSep
	print(finalXSep)
	if allCardsSize > size.x:
		finalXSep = (size.x - CARDSIZE * cards) / (cards-1)
		allCardsSize = size.x
	var offset = (size.x - allCardsSize) / 2
	for i in range(cards):
		var card = get_child(i)
		var yMultiplayer = handCurve.sample(1.0 / (cards-1) * i)
		var rotMultiplayer = rotationCurve.sample(1.0 / (cards-1) * i)
		
		if cards == 1:
			yMultiplayer = 0.0
			rotMultiplayer = 0.0
		var finalX: float = offset + CARDSIZE * i + 5 * i
		var finalY: float = yMin + yMax * yMultiplayer
		
		card.position = Vector2(finalX, finalY)
		card.rotation = deg_to_rad(maxRotationDegrees * rotMultiplayer)
