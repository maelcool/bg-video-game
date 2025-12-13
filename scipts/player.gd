extends CharacterBody2D

var move_speed: float = 150.0
var jump_force: float = -300.0
var gravity: float = 900.0
@onready var animated_sprite = $AnimatedSprite2D
var time_since_idled = 0
var time_until_idle = randf_range(5,10)
var idle_played: bool = false

var input_vector = Vector2.ZERO

func _physics_process(delta):
	input_vector.x = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	velocity.x = input_vector.x * move_speed

	if input_vector.x != 0:
		animated_sprite.play("Walk")
		animated_sprite.flip_h = input_vector.x < 0
		time_since_idled = 0
		if idle_played:
			time_until_idle = randf_range(5,10)
	else:
		time_since_idled += delta
		if time_since_idled >= time_until_idle:
			animated_sprite.play("Idle")
		else:
			if animated_sprite.animation != "nothing":
				animated_sprite.play("nothing")

	if !is_on_floor():
		velocity.y += gravity * delta
	else:
		if Input.is_action_just_pressed("Jump"):
			velocity.y = jump_force

	move_and_slide()

	# Pixel-perfect (optional but good for pixel art)
	position = position.round()
