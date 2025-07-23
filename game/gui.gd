extends CanvasLayer

var rooms: Array[RoomData] = []

func _ready():
	$VBoxContainer/Interactables/AddRoom.pressed.connect(open_dialog)

func open_dialog():
	var dialog_window = preload("res://game/room_select_dialog.tscn").instantiate()
	dialog_window.options = [RoomData.BEDROOM, RoomData.DINING_ROOM, RoomData.KITCHEN]
	dialog_window.accepted.connect(add_room)
	get_tree().root.add_child(dialog_window)

func add_room(selected_room: RoomData):
	# create a room
	var room = Room.create_room(selected_room)
	# Based on the size of the placeholder room image
	room.position = Vector2(rooms.size() * (650 + 10), 0)
	$VBoxContainer/GameWindow/Rooms.add_child(room)
	rooms.append(selected_room)
	update_resources()
	

func update_resources():
	var resources = {}
	for resource in RoomData.Resources.values():
		resources[resource] = 0
		for room in rooms:
			resources[resource] += room.resources.get(resource, 0)
			
	$VBoxContainer/PanelContainer/HBoxContainer/Money.set_value(resources[RoomData.Resources.MONEY])
	$VBoxContainer/PanelContainer/HBoxContainer/Social.set_value(resources[RoomData.Resources.SOCIAL])
	$VBoxContainer/PanelContainer/HBoxContainer/Occupancy.set_value(resources[RoomData.Resources.OCCUPANCY])
	$VBoxContainer/PanelContainer/HBoxContainer2/Food.set_value(resources[RoomData.Resources.FOOD])
	return
