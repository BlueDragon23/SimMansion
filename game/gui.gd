extends CanvasLayer

enum GameState {
	RUNNING,
	PLACING,
	PAUSED
}

var selected_room: Room = null
var placing_room: Room = null
var placing_overlay = null
var game_state := GameState.RUNNING
var state := State.new()

func _ready():
	%AddRoom.pressed.connect(open_dialog.bind(start_room_placement, get_add_room_options, "Add Room"))
	%UpgradeRoom.pressed.connect(open_dialog.bind(upgrade_room, get_upgrade_room_options, "Upgrade Room"))
	# Initial house stuff. Maybe just for testing?
	add_room(Vector2(0, 0), Rooms.bedroom)
	add_room(Vector2(500, 0), Rooms.office)
	# reset money because I pay for my initial rooms lol
	state.connect_for_resource_type(RoomData.Resources.ROOM_TOKENS, %Tokens.set_value)
	state.update_resource(RoomData.Resources.ROOM_TOKENS, 10)
	state.connect_for_resource_type(RoomData.Resources.OCCUPANCY, %Occupancy.set_value)
	state.connect_for_resource_type(RoomData.Resources.SOCIAL, %Social.set_value)
	state.connect_for_resource_type(RoomData.Resources.COMFORT, %Comfort.set_value)
	state.connect_for_resource_type(RoomData.Resources.LEISURE, %Leisure.set_value)
	state.connect_for_resource_type(RoomData.Resources.FOOD, %Food.set_value)
	$VBoxContainer/GameWindow.room_selected.connect(room_selected)
	$VBoxContainer/GameWindow.room_deselected.connect(room_deselected)

func open_dialog(on_accept, get_options, title: String):
	var dialog_window = preload("res://game/room_select_dialog.tscn").instantiate()
	dialog_window.title = title
	dialog_window.options = get_options.call()
	dialog_window.accepted.connect(on_accept)
	dialog_window.accepted.connect(func a(): self.game_state = GameState.RUNNING)
	dialog_window.canceled.connect(func cancel(): self.game_state = GameState.RUNNING)
	dialog_window.available_money = %Tokens.value
	game_state = GameState.PAUSED
	get_tree().root.add_child(dialog_window)
	
func get_add_room_options() -> Array[Room]:
	return AvailableRooms.get_available_rooms()

func start_room_placement(adding_room: Room):
	self.game_state = GameState.PLACING
	self.placing_room = adding_room
	var placing_overlay = preload("res://game/widgets/placing_room.tscn").instantiate()
	placing_overlay.add_child(RoomUI.create_room(adding_room))
	self.placing_overlay = placing_overlay
	add_child(placing_overlay)
	placing_overlay.on_click.connect(add_room.bind(adding_room))

func add_room(position: Vector2, added_room: Room):
	if %GameWindow.is_valid_placement(Rect2(position, Vector2(500, 500))):
		self.game_state = GameState.RUNNING
		remove_child(self.placing_overlay)
		self.placing_overlay = null
		state.add_room(added_room)
		%GameWindow.add_room(added_room, position)
		AvailableRooms.refresh_available_rooms()
	
func room_selected(room: Room):
	#TODO: better selection state
	self.selected_room = room
	%UpgradeRoom.disabled = false
	
func room_deselected():
	self.selected_room = null
	%UpgradeRoom.disabled = true
	
func get_upgrade_room_options() -> Array[Room]:
	return selected_room.upgrades_to

func upgrade_room(upgraded_room: Room):
	# We're replacing the selected room
	self.game_state = GameState.RUNNING
	# TODO: there's definitely race conditions on selecting a different room
	state.rooms.set(state.rooms.find(selected_room), upgraded_room)
	$VBoxContainer/GameWindow.remove_room(selected_room)
	$VBoxContainer/GameWindow.add_room(upgraded_room)
	room_deselected()
