extends Node2D

@onready var level_container = $World/Level  

func _ready():
	load_level("LevelChoser")  
	Global.currentScenePath = Global.level_scenes["LevelChoser"]
	Global.currentSceneNumber = 1
	$GUI.night_emitted.connect(_on_night_called)
	Global.slept.connect(_on_slept_called)
	Global.game = self

func load_level(level_key: String):
	print("LOAD LEVEL CALLED with level key" + level_key)
	if Global.currentScenePath == Global.level_scenes[level_key]:
		return
	if Global.currentSceneInstance != null:
		Global.currentSceneInstance.queue_free()
		Global.currentSceneInstance = null
	if Global.level_scenes.has(level_key):
		var scene_resource = load(Global.level_scenes[level_key])
		Global.currentSceneInstance = scene_resource.instantiate()
		level_container.add_child(Global.currentSceneInstance)
		Global.currentScenePath = Global.level_scenes[level_key]
	else:
		push_error("Level not found: %s" % level_key)

	if Global.currentSceneInstance.has_node("Door"):
		var door_node = Global.currentSceneInstance.get_node("Door")
		var callback = Callable(self, "_on_next_level_called")
		if not door_node.is_connected("next_level", callback):
			door_node.connect("next_level", callback)

func _on_next_level_called():
	if Global.currentSceneNumber == 1:
		load_level("Level2")
		Global.currentSceneNumber = 2
	elif  Global.currentSceneNumber == 2:
		load_level("Level3")
		Global.currentSceneNumber = 3

func _on_night_called():
	load_level("Night")

func _on_slept_called():
	if Global.currentSceneNumber == 1:
		load_level("Level1")
		Global.currentSceneNumber = 1
	elif  Global.currentSceneNumber == 2:
		load_level("Level2")
		Global.currentSceneNumber = 2
	elif  Global.currentSceneNumber == 23:
		load_level("Level3")
		Global.currentSceneNumber = 3
	Global.stopTime = false
