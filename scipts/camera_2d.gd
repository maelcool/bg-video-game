extends Camera2D

func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	if Global.currentSceneNumber == -1 or Global.currentSceneNumber == 2:
		zoom = Vector2(1,1)
	elif Global.currentSceneNumber == 1:
		zoom = Vector2(2,2)
		limit_top = 150
	else:
		zoom = Vector2(2,2)
