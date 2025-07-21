extends Button

# TODO: make this part of the GUI script, not a separate script
func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			open_dialog()

func open_dialog():
	var dialog_window = preload("res://game/room_select_dialog.tscn").instantiate()
	dialog_window.options = [RoomData.BEDROOM, RoomData.DINING_ROOM, RoomData.KITCHEN]
	dialog_window.accepted.connect(add_room)
	get_node("../../").add_child(dialog_window)

func add_room(selected_room: RoomData):
	# create a room
	var room = Room.create_room(selected_room)
	var roomContainer = get_node("../../GameWindow/Rooms")
	# Based on the size of the placeholder room image
	room.position = Vector2(roomContainer.get_child_count() * (650 + 10), 0)
	# display it somehow
	roomContainer.add_child(room)
	
