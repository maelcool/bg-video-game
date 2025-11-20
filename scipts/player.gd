extends CharacterBody2D

var move_speed: float = 4.0
var jump_force: float = 3.0
var gravity: float = 10

var facing_angle: float

enum State{Idle, Run}

@onready var player: CharacterBody2D = self

func _physics_process(delta):
	player_falling(delta)
	move_and_slide()
	
func player_falling(delta):
	if !is_on_floor():
		velocity.y += gravity * delta
