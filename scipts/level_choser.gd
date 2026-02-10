extends Node2D

@export var numberOfRoomsPerLine: int = 5

@onready var roomScene = preload("res://assets/scenes/room_node.tscn")
@onready var control = $Control

var grassRoom: Dictionary = {
	"Goblin": preload("res://rooms/goblin.tres"),
	"Mystery": preload("res://rooms/mystery.tres"), 
	"Camp": preload("res://rooms/camp.tres"), 
	"Chest": preload("res://rooms/chest.tres")
	 }
var forestRoom: Dictionary = {
	"Witch": preload("res://rooms/witch.tres") , 
	"Mystery": preload("res://rooms/mystery.tres"), 
	"Camp": preload("res://rooms/camp.tres"), 
	"Chest": preload("res://rooms/chest.tres")
	}
var dungeonRoom:Dictionary =  {
	"Knight": preload("res://rooms/knight.tres"), 
	"Mystery": preload("res://rooms/mystery.tres"), 
	"Camp": preload("res://rooms/camp.tres"), 
	"Chest": preload("res://rooms/chest.tres")
	}

var specialRoom:Dictionary= { 
	"Bar" : preload("res://rooms/bar.tres") , 
	"DragonBoss" : preload("res://rooms/dragonBoss.tres") }

var spaceBetweenRooms := 250.0 / numberOfRoomsPerLine

func _ready():
	if Global.amountVisited != 0:
		print(" SECOND TIME BABY" + str(Global.amountVisited))
		loadTree()
		_lock_rooms()
	else:
		print("First TIME BABY " + str(Global.amountVisited))
		createRoomTree()
		loadTree()
	Global.amountVisited += 1


# --------------------------------------------------
# ROOM CREATION
# --------------------------------------------------

func createRoomTree():
	if Global.treeGenerated:
		return
	
	# Bar
	Global.roomTree.append(specialRoom.get("Bar"))
	
	#randomly append for each line
	for x in range(numberOfRoomsPerLine):
		Global.roomTree.append(grassRoom.values().pick_random())
		Global.roomTree[Global.roomTree.size()-1].line = 1
		print(Global.roomTree[Global.roomTree.size()-1].line)
	for x in range(numberOfRoomsPerLine):
		Global.roomTree.append(forestRoom.values().pick_random())
		Global.roomTree[Global.roomTree.size()-1].line = 2
	for x in range(numberOfRoomsPerLine):
		Global.roomTree.append(dungeonRoom.values().pick_random())
		Global.roomTree[Global.roomTree.size()-1].line = 3
	
	# DragonBoss
	Global.roomTree.append(specialRoom.get("DragonBoss"))

func loadTree():
	var counter = 0
	for i in Global.roomTree:
		counter += 1
		var specificRoomScene = roomScene.instantiate()
		specificRoomScene.get_child(0).text = "[center][b]%s[/b][/center]" % i.room_name
		specificRoomScene.pressed.connect(func():
			print("PRESSDED BUTTONS")
			_onRoomPressed(i)
		)
		control.add_child(specificRoomScene)
		if counter == 1:
			specificRoomScene.position = Vector2(20, 90)
		elif counter <= (Global.roomTree.size() / 3.0) +1:
			specificRoomScene.position = Vector2((counter-1) * spaceBetweenRooms, 45)
		elif counter <= ((Global.roomTree.size()*2) / 3.0) :

			specificRoomScene.position = Vector2((counter- numberOfRoomsPerLine-1) * spaceBetweenRooms, 90)
		elif counter < (Global.roomTree.size()):
			specificRoomScene.position = Vector2((counter - (2 * numberOfRoomsPerLine)-1) * spaceBetweenRooms, 135)
		else:
			specificRoomScene.position = Vector2(280, 90)

func _onRoomPressed(room: RoomStats):
	print("ON ROOM PRESSD" + str(room.line) + str(room.room_name))
	Global.load_level(room.line, room.room_name)


func _lock_rooms():
	pass
