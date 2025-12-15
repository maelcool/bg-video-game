extends Camera2D

func _ready() -> void:
	limit_left = -8
	limit_bottom = 200
	
func _process(delta: float) -> void:
	position = position.lerp($"../Player".position, delta * 3)
	if Global.currentSceneNumber == 2:
		limit_right = 1000
	elif Global.currentSceneNumber == 3:
		limit_left = 0
		limit_right = 420
		
		
		
