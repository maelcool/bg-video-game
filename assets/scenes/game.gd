extends Node2D

var level_scenes = {
	"Level1": "res://assets/scenes/level_1.tscn",
	"Level2": "res://assets/scenes/level_2.tscn",
	"Level3": "res://assets/scenes/level_3.tscn",
	"Night": "res://assets/scenes/night.tscn"
}

@onready var player = $World/Player
@onready var level_container = $World/Level  

func _ready():
	load_level("Level1")  
	Global.currentScenePath = level_scenes["Level1"]
	Global.currentSceneNumber = 1
	$GUI.night_emitted.connect(_on_night_called)
	Global.slept.connect(_on_slept_called)

func load_level(level_key: String):
	print("LOAD LEVEL CALLED with level key" + level_key)
	if Global.currentScenePath == level_scenes[level_key]:
		return
	if Global.currentSceneInstance != null:
		Global.currentSceneInstance.queue_free()
		Global.currentSceneInstance = null
	if level_scenes.has(level_key):
		var scene_resource = load(level_scenes[level_key])
		Global.currentSceneInstance = scene_resource.instantiate()
		level_container.add_child(Global.currentSceneInstance)
		Global.currentScenePath = level_scenes[level_key]
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
	player.position = Vector2(79, 140)

func _on_night_called():
	load_level("Night")
	player.position = Vector2(79, 140)

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
	player.position = Vector2(79, 140)
	Global.stopTime = false
