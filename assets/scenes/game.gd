extends Node2D

var level_scenes = {
	"Level1": "res://assets/scenes/level_1.tscn",
	"Level2": "res://assets/scenes/level_2.tscn",
	"Night": "res://assets/scenes/night.tscn"
}

@onready var player = $World/Player
@onready var level_container = $World/Level  # This is where levels go

func _ready():
	load_level("Level1")  # pass the key, not the path
	Global.currentScenePath = level_scenes["Level1"]
	$GUI.night.connect(_on_night_called)

func load_level(level_key: String):
	print("LOAD LEVEL CALLED")
	# If already on this level, do nothing
	if Global.currentScenePath == level_scenes[level_key]:
		return
	
	# Free previous level instance
	if Global.currentSceneInstance != null:
		Global.currentSceneInstance.queue_free()
		Global.currentSceneInstance = null

	# Load new level
	if level_scenes.has(level_key):
		var scene_resource = load(level_scenes[level_key])
		Global.currentSceneInstance = scene_resource.instantiate()
		level_container.add_child(Global.currentSceneInstance)
		Global.currentScenePath = level_scenes[level_key]
	else:
		push_error("Level not found: %s" % level_key)
	
	 # Connect the Door signal if it exists
	if Global.currentSceneInstance.has_node("Door"):
		var door_node = Global.currentSceneInstance.get_node("Door")
		var callback = Callable(self, "_on_level2_called")
		if not door_node.is_connected("level2", callback):
			door_node.connect("level2", callback)

func _on_level2_called():
	print("2 LEVEL CALLED")
	load_level("Level2")
	player.position = Vector2(79, 140)

func _on_night_called():
	print("NIGHT bekommen")
	load_level("Night")
	player.position = Vector2(79, 140)
