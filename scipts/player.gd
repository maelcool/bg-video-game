extends CharacterBody2D

@export var move_speed: float = 50.0
@export var jump_force: float = -225.0
@export var gravity: float = 500.0
@onready var animated_sprite: AnimatedSprite2D 
@onready var witchAnimator = $WitchAnimator
@onready var knightAnimator = $KnightAnimator
var time_since_idled = 0
var time_until_idle = randf_range(5,10)
var idle_played: bool = false
var attacking: bool = false

var input_vector = Vector2.ZERO

func _ready():
	witchAnimator.animation_finished.connect(_on_animation_finished)
	knightAnimator.animation_finished.connect(_on_animation_finished)
	if Global.playerCharacter == "Witch":
		print("Witch: " + Global.playerCharacter)
		animated_sprite = witchAnimator
		knightAnimator.visible = false
		witchAnimator.visible = true
	elif Global.playerCharacter == "Knight":
		print("Knight: " + Global.playerCharacter)
		animated_sprite = knightAnimator
		witchAnimator.visible = false
		knightAnimator.visible = true

func _physics_process(delta):
	if Global.isPlayerinFight:
		return
	if Input.is_action_just_pressed("Attack") and !attacking:
		attacking = true
		play_if_not("Attack")
		return

	input_vector.x = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	velocity.x = input_vector.x * move_speed

	if input_vector.x != 0:
		play_if_not("Walk")
		animated_sprite.flip_h = input_vector.x < 0
		time_since_idled = 0
	else:
		time_since_idled += delta
		if time_since_idled >= time_until_idle:
			play_if_not("Idle")
		else:
			play_if_not("Nothing")

	if !is_on_floor():
		velocity.y += gravity * delta
	elif Input.is_action_just_pressed("Jump"):
		velocity.y = jump_force

	move_and_slide()
	position = position.round()
	if Input.is_action_just_pressed("Attack"):
		attacking = true
		animated_sprite.play("Attack")
	
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
			if animated_sprite.animation != "Nothing" and !attacking:
				animated_sprite.play("Nothing")

	if !is_on_floor():
		velocity.y += gravity * delta
	else:
		if Input.is_action_just_pressed("Jump"):
			velocity.y = jump_force

	move_and_slide()

	position = position.round()

func play_if_not(anim: String):
	if animated_sprite.animation != anim:
		animated_sprite.play(anim)


func _on_animation_finished():
	if animated_sprite.animation == "Attack":
		attacking = false
