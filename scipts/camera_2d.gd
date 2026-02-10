extends Camera2D

func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	if Global.currentSceneNumber == -1:
		zoom = Vector2(1,1)
	elif Global.currentSceneNumber == 1:
		zoom = Vector2(2,2)
		limit_top = 150
	elif Global.currentSceneNumber == 3:
		zoom = Vector2(2,2)
		limit_top = 100
		limit_right = 350
		limit_left = 120
	else:
		zoom = Vector2(2,2)
