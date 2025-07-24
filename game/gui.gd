extends CanvasLayer

var rooms: Array[RoomData] = []
var selected_room: Room = null

func _ready():
	$VBoxContainer/Interactables/AddRoom.pressed.connect(open_dialog.bind(add_room, get_add_room_options))
	$VBoxContainer/Interactables/UpgradeRoom.pressed.connect(open_dialog.bind(upgrade_room, get_upgrade_room_options))
	$VBoxContainer/GameWindow.gui_input.connect(func handle(event):
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
				room_deselected()
	)
	# Initial house stuff. Maybe just for testing?
	add_room(RoomData.BEDROOM)

func open_dialog(on_accept, get_options):
	var dialog_window = preload("res://game/room_select_dialog.tscn").instantiate()
	dialog_window.options = get_options.call()
	dialog_window.accepted.connect(on_accept)
	get_tree().root.add_child(dialog_window)
	
func get_add_room_options() -> Array[RoomData]:
	return [RoomData.KITCHEN, RoomData.DINING_ROOM, RoomData.BEDROOM]

func add_room(added_room: RoomData):
	# create a room
	var room = Room.create_room(added_room)
	# Based on the size of the placeholder room image
	room.position = Vector2(rooms.size() * (650 + 10), 0)
	$VBoxContainer/GameWindow/Rooms.add_child(room)
	rooms.append(added_room)
	room.room_selected.connect(room_selected.bind(room))
	update_resources()
	
func room_selected(room: Room):
	#TODO: better selection state
	self.selected_room = room
	$VBoxContainer/Interactables/UpgradeRoom.disabled = false
	
func room_deselected():
	self.selected_room = null
	$VBoxContainer/Interactables/UpgradeRoom.disabled = true
	
func get_upgrade_room_options() -> Array[RoomData]:
	# types are hard https://github.com/godotengine/godot/issues/72566
	var upgrade_options: Array[RoomData]
	upgrade_options.assign(selected_room.room_data.upgrades_to	.map(func (r): return RoomData.ROOM_LOOKUP[r]))
	return upgrade_options

func upgrade_room(upgraded_room: RoomData):
	var room = Room.create_room(upgraded_room)
	# We're replacing the selected room
	# TODO: there's definitely race conditions on selecting a different room
	room.position = selected_room.position
	room.room_selected.connect(room_selected.bind(room))
	rooms.set(rooms.find(selected_room.room_data), upgraded_room)
	$VBoxContainer/GameWindow/Rooms.add_child(room)
	$VBoxContainer/GameWindow/Rooms.remove_child(selected_room)
	room_deselected()
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
