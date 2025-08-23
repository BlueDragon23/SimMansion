extends Control

signal room_selected
signal room_deselected

func add_room(added_room: Room):
	var room = RoomUI.create_room(added_room)
	# Based on the size of the placeholder room image
	room.position = Vector2($Rooms.get_children().size() * (650 + 10), 0)
	$Rooms.add_child(room)
	room.room_selected.connect(func s(): room_selected.emit(added_room))
	reshuffle()
	
func remove_room(removed_room: Room):
	var node = $Rooms.get_node(removed_room.name)
	$Rooms.remove_child(node)
	reshuffle()

# TODO: this is a dumb hack
func reshuffle():
	var x = 0
	var y = 0
	for r in $Rooms.get_children():
		r.position = Vector2(x, y)
		x += 660
		y += 0

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			print("Deselected room")
			room_deselected.emit()
