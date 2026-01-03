class_name ActionPanel
extends PanelContainer

@onready var add_room_button = %AddRoom
@onready var upgrade_room_button = %UpgradeRoom

signal update_game_state(state: State.GameState)
signal start_room_placement(room: Room)
signal upgrade_room(room: Room)

var current_tokens: int
var selected_room: Room

func _ready():
	add_room_button.pressed.connect(open_dialog.bind(func(r): start_room_placement.emit(r), AvailableRooms.get_available_rooms, "Add Room"))
	# TODO: null handling for selected room
	upgrade_room_button.pressed.connect(open_dialog.bind(handle_upgrade_room, func(): return selected_room.upgrades_to, "Upgrade Room"))

func update_tokens(new_tokens: int):
	self.current_tokens = new_tokens
	
func update_selected_room(selected_room: Room):
	self.selected_room = selected_room
	upgrade_room_button.disabled = (selected_room == null)

func open_dialog(on_accept: Callable, get_options: Callable, title: String):
	var dialog_window = preload("res://game//widgets/room_select_dialog.tscn").instantiate()
	dialog_window.title = title
	dialog_window.options = get_options.call()
	dialog_window.accepted.connect(on_accept)
	dialog_window.accepted.connect(func a(_r): update_game_state.emit(State.GameState.RUNNING))
	dialog_window.canceled.connect(func cancel(): update_game_state.emit(State.GameState.RUNNING))
	dialog_window.available_money = current_tokens
	update_game_state.emit(State.GameState.PAUSED)
	get_tree().root.add_child(dialog_window)

func handle_upgrade_room(room: Room):
	upgrade_room.emit(room)
	update_selected_room(null)
