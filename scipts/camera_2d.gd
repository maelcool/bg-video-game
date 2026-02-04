extends Camera2D

func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	if Global.currentSceneNumber == 1:
		limit_right = 418
		limit_left = 0
		limit_bottom = 180
		limit_top = 0
	elif Global.currentSceneNumber == 2:
		limit_right = 1000
	elif Global.currentSceneNumber == 3:
		limit_left = 0
		limit_right = 320
		
		
		
