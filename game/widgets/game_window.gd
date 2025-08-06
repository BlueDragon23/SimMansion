extends Control

signal room_selected
signal room_deselected

func add_room(added_room: RoomData):
	var room = Room.create_room(added_room)
	# Based on the size of the placeholder room image
	room.position = Vector2($Rooms.get_children().size() * (650 + 10), 0)
	$Rooms.add_child(room)
	room.room_selected.connect(func s(): room_selected.emit(room))

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			room_deselected.emit()
