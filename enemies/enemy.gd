extends Node2D

@export var enemyStats: EnemyStats 


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func attack():
	var actions = enemyStats.cards
	for i in actions:
		i.print(i)
