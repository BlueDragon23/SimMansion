extends Control

signal room_selected
signal room_deselected

# TODO: how to make this scalable?
static var GRID_SIZE = 100

func _ready():
	# Setup grid 
	var window_size = get_window().size
	var thickness = 4
	for x in range(0, window_size.x, GRID_SIZE):
		var sep = VSeparator.new()
		sep.position = Vector2(x, 0)
		sep.size = Vector2(thickness, window_size.y)
		%Overlay.add_child(sep)
	for y in range(0, window_size.y, GRID_SIZE):
		var sep = HSeparator.new()
		sep.position = Vector2(0, y)
		sep.size = Vector2(window_size.x, thickness)
		%Overlay.add_child(sep)

func add_room(added_room: Room, position: Vector2 = Vector2(100_000, 100_000)):
	var room = RoomUI.create_room(added_room)
	%Rooms.add_child(room)
	var base_position: Vector2
	if position == Vector2(100_000, 100_000):
		base_position = get_local_mouse_position()
		room.position = get_grid_square(base_position) * GRID_SIZE
	else:
		room.position = get_grid_square(position) * GRID_SIZE
	room.room_selected.connect(func s(): room_selected.emit(added_room))
	
func remove_room(removed_room: Room):
	var node = %Rooms.get_node(removed_room.name)
	%Rooms.remove_child(node)
	reshuffle()

# TODO: this is a dumb hack
func reshuffle():
	var x = 0
	var y = 0
	for r in %Rooms.get_children():
		# TODO: assuming square polygon
		var corner = r.get_children()[1].get_polygon()[2]
		if (x + corner.x > get_window().size.x):
			y += 500
			x = 0
		r.position = Vector2(x, y)
		x += corner.x
		
func get_grid_square(coord: Vector2) -> Vector2i:
	return Vector2i(coord.snapped(Vector2(GRID_SIZE, GRID_SIZE)) / GRID_SIZE)
	
func is_valid_placement(proposed: Rect2) -> bool:
	for r in %Rooms.get_children():
		# TODO: hack
		var actual = Rect2(r.position, r.get_children()[1].get_polygon()[2])
		if actual.intersects(proposed):
			return false
	return true

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var snapped = (event.position / 100).floor() * 100
		print(is_valid_placement(Rect2(snapped, Vector2(500, 500))))
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			room_deselected.emit()
