extends Node2D

@export var numberOfRoomsPerLine = 5
@export var roomNode = preload("res://assets/scenes/room_node.tscn")

@onready var firstRoomNode = $Control/RoomNode
@onready var control = $Control
@onready var background = $Control/Background

enum rooms{Grasslevel, Camp, Random, Chest}
enum grassRooms{Witch, Knight, Mystery, Camp, Chest}
enum dungeonRoom{Leprechaun, Troll, Mystery, Camp, Chest}
enum specificRooms{Bar, DragonBossfight}
var tree: Array = []
var spaceBetweenRooms:float = 250.0 / numberOfRoomsPerLine

var pathChosen: int 
var levelOnPathOne: Array = []
var levelOnPathTwo: Array = []
var levelOnPathThree: Array = []
var enteredRooms: Array = []

# Called when the node enters the scene tree for the first time.
func _ready():
	_createSpecificRoom(specificRooms.Bar)
	for i in range(numberOfRoomsPerLine):
		_addChildToRoomNode(1)
	for i in range(numberOfRoomsPerLine):
		_addChildToRoomNode(2)
	for i in range(numberOfRoomsPerLine):
		_addChildToRoomNode(3)
	_createSpecificRoom(specificRooms.DragonBossfight)



func _addChildToRoomNode(line: int):
	var newRoom = roomNode.instantiate()
	newRoom = _randomizeRoom(newRoom, line)
	control.add_child(newRoom)
	tree.append(newRoom)

func _randomizeRoom(room: TextureButton, line: int) -> TextureButton:
	var randomRoom
	var randomName:String
	match line:
		1:
			randomRoom = grassRooms.values().pick_random()
			randomName = grassRooms.keys()[randomRoom] 
			room.position = Vector2(((tree.size())*spaceBetweenRooms),45)
			levelOnPathOne.append(randomName)
		2:
			randomRoom = rooms.values().pick_random()
			randomName = rooms.keys()[randomRoom] 
			room.position = Vector2(((tree.size()-numberOfRoomsPerLine)*spaceBetweenRooms),90)
			levelOnPathTwo.append(randomName)
		3:
			randomRoom = dungeonRoom.values().pick_random()
			randomName = dungeonRoom.keys()[randomRoom] 
			room.position = Vector2(((tree.size()-2*numberOfRoomsPerLine)*spaceBetweenRooms),135)
			levelOnPathThree.append(randomName)
	room.get_child(0).text = "[center][color=white][b]" + randomName +"[/b][/color][/center]"
	room.pressed.connect(func():
		_roomButtonPressed(randomName)
	)
	return room

func _createSpecificRoom(wichRoom: specificRooms):
	var newRoom = roomNode.instantiate()
	var roomName
	match wichRoom:
		specificRooms.Bar:
			newRoom.position = Vector2(20,90)
			newRoom.get_child(0).text = "[center][color=dark_green][b]Bar[/b][/color][/center]"
			roomName = "Bar"
		specificRooms.DragonBossfight:
			newRoom.position = Vector2(280,90)
			newRoom.get_child(0).text = "[center][color=dark_red][b]Boss[/b][/color][/center]"
			roomName ="DragonFight"
	control.add_child(newRoom)
	tree.append(newRoom)
	newRoom.pressed.connect(func():
		_roomButtonPressed(roomName)
	)
	
func _roomButtonPressed(name: String):
	print("Triggered")
	_appendEnetredRooms(name)
	match  name:
		"Chest":
			print("printed ")
			Global.load_level("Chest")
			#SceneManager.change_scene(Global.level_scenes.get("Chest"))
		"Witch":
			pass
			#SceneManager.change_scene(Global.level_scenes.get("Witch"))
		"Knight":
			pass
			#SceneManager.change_scene(Global.level_scenes.get("Knight"))
		"Camp":
			pass
			#SceneManager.change_scene(Global.level_scenes.get("Camp"))
		"Bar":
			Global.load_level("Bar")
			#SceneManager.change_scene(Global.level_scenes.get("Bar"))


func _appendEnetredRooms(roomName: String):
	if pathChosen == 1:
		for i in levelOnPathOne:
			enteredRooms.append(i)
			i.disable = true
		for i in levelOnPathOne:
			enteredRooms.append(i)
	elif pathChosen == 2:
		for i in levelOnPathOne:
			enteredRooms.append(i)
		for i in levelOnPathOne:
			enteredRooms.append(i)
	else:
		for i in levelOnPathOne:
			enteredRooms.append(i)
		for i in levelOnPathOne:
			enteredRooms.append(i)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
