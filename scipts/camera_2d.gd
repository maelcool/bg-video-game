extends Camera2D

func _ready() -> void:
	limit_left = -8
	limit_bottom = 200
	
func _process(delta: float) -> void:
	position = position.lerp($"../Player".position, delta * 3)
