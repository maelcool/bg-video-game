extends RigidBody2D

@onready var healthBar = $ProgressBar
@onready var bossText = $CanvasLayer/BossLabel


func _on_fight_area_body_entered(body):
	if body is CharacterBody2D:
		healthBar.visible = true
		bossText.visible = true
		Global.fightTriggered(self)
	
