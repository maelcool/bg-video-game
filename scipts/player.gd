extends CharacterBody2D

@export var move_speed: float = 0
@export var jump_force: float = -225.0
@export var gravity: float = 0
@onready var animated_sprite: AnimatedSprite2D 
@onready var witchAnimator = $WitchAnimator
@onready var knightAnimator = $KnightAnimator
@onready var gpuParticles = $GPUParticles2D
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
		gpuParticles.emitting = true
		return

	if Input.is_action_just_pressed("Attack"):
		attacking = true
		animated_sprite.play("Attack")

func play_if_not(anim: String):
	if animated_sprite.animation != anim:
		animated_sprite.play(anim)


func _on_animation_finished():
	if animated_sprite.animation == "Attack":
		attacking = false
