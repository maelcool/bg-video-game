extends Node2D

@export var numberOfRoomsPerLine = 5
@export var roomNode = preload("res://assets/scenes/room_node.tscn")

@onready var firstRoomNode = $Control/RoomNode
@onready var control = $Control
@onready var background = $Control/Background

enum rooms{Grasslevel, Camp, Random, Chest}
enum specificRooms{Bar, DragonBossfight}
var tree: Array = []
var spaceBetweenRooms:float = 250.0 / numberOfRoomsPerLine


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
	_drawAllTheLines()

func _drawAllTheLines():
	for index in range(tree.size()):
		print("INDEX: " + str(index))
		match index:
			0:
				pass
			1,2,3:
				print("SHOULD BE DRAWING")
				background.positionOne = Vector2(20,90)
				background.positionTwo = Vector2(((index)*spaceBetweenRooms),45)
				background.queue_redraw()

func _addChildToRoomNode(line: int):
	var newRoom = roomNode.instantiate()
	newRoom = _randomizeRoom(newRoom, line)
	control.add_child(newRoom)
	tree.append(newRoom)

func _randomizeRoom(room: TextureButton, line: int) -> TextureButton:
	var randomRoom = rooms.values().pick_random()
	var randomName:String = rooms.keys()[randomRoom] 
	room.get_child(0).text = "[center][color=black][b]" + randomName +"[/b][/color][/center]"
	match line:
		1:
			room.position = Vector2(((tree.size())*spaceBetweenRooms),45)
		2:
			room.position = Vector2(((tree.size()-numberOfRoomsPerLine)*spaceBetweenRooms),90)
		3:
			room.position = Vector2(((tree.size()-2*numberOfRoomsPerLine)*spaceBetweenRooms),135)
	return room

func _createSpecificRoom(wichRoom: specificRooms):
	var newRoom = roomNode.instantiate()
	match wichRoom:
		specificRooms.Bar:
			newRoom.position = Vector2(20,90)
			newRoom.get_child(0).text = "[center][color=black][b]Bar[/b][/color][/center]"
		specificRooms.DragonBossfight:
			newRoom.position = Vector2(280,90)
			newRoom.get_child(0).text = "[center][color=red][b]Boss[/b][/color][/center]"
	control.add_child(newRoom)
	tree.append(newRoom)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
