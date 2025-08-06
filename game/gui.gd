extends CanvasLayer

## How many milliseconds pass between each money grant
const MONEY_RATE = 2000

enum GameState {
	RUNNING,
	PAUSED
}

var selected_room: Room = null
var last_money = Time.get_ticks_msec()
var game_state = GameState.RUNNING
var state = State.new()

func _ready():
	$VBoxContainer/Interactables/AddRoom.pressed.connect(open_dialog.bind(add_room, get_add_room_options))
	$VBoxContainer/Interactables/UpgradeRoom.pressed.connect(open_dialog.bind(upgrade_room, get_upgrade_room_options))
	# Initial house stuff. Maybe just for testing?
	add_room(RoomData.BEDROOM)
	add_room(RoomData.OFFICE)
	# reset money because I pay for my initial rooms lol
	state.connect_for_resource_type(RoomData.Resources.MONEY, $VBoxContainer/PanelContainer/HBoxContainer/Money.set_value)
	state.update_resource(RoomData.Resources.MONEY, 20)
	state.connect_for_resource_type(RoomData.Resources.OCCUPANCY, $VBoxContainer/PanelContainer/HBoxContainer/Occupancy.set_value)
	state.connect_for_resource_type(RoomData.Resources.FOOD, $VBoxContainer/PanelContainer/HBoxContainer2/Food.set_value)
	$VBoxContainer/GameWindow.room_selected.connect(room_selected)
	$VBoxContainer/GameWindow.room_deselected.connect(room_deselected)
	
func _process(delta):
	# TODO: we should only track how much time has passed while the game is running for the purpose of money ticks
	if (game_state == GameState.RUNNING and Time.get_ticks_msec() - last_money > MONEY_RATE):
		# TODO: performance lol
		var increase = state.rooms.reduce(func cash(accum: int, r: RoomData): return accum + r.resources.get(RoomData.Resources.MONEY, 0), 0)
		state.update_resource(RoomData.Resources.MONEY, increase)
		last_money = Time.get_ticks_msec()

func open_dialog(on_accept, get_options):
	var dialog_window = preload("res://game/room_select_dialog.tscn").instantiate()
	dialog_window.options = get_options.call()
	dialog_window.accepted.connect(on_accept)
	dialog_window.accepted.connect(func a(): self.game_state = GameState.RUNNING)
	dialog_window.canceled.connect(func cancel(): self.game_state = GameState.RUNNING)
	dialog_window.available_money = $VBoxContainer/PanelContainer/HBoxContainer/Money.value
	game_state = GameState.PAUSED
	get_tree().root.add_child(dialog_window)
	
func get_add_room_options() -> Array[RoomData]:
	return [RoomData.KITCHEN, RoomData.DINING_ROOM, RoomData.BEDROOM]

func add_room(added_room: RoomData):
	state.add_room(added_room)
	$VBoxContainer/GameWindow.add_room(added_room)
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
	state.rooms.set(state.rooms.find(selected_room.room_data), upgraded_room)
	$VBoxContainer/GameWindow/Rooms.add_child(room)
	$VBoxContainer/GameWindow/Rooms.remove_child(selected_room)
	room_deselected()
	state.update_resource(RoomData.Resources.MONEY, -upgraded_room.cost)
	update_resources()
	

func update_resources():
	# TODO: move this into state
	var resources = {}
	for resource in RoomData.Resources.values():
		resources[resource] = 0
		for room in state.rooms:
			resources[resource] += room.resources.get(resource, 0)
			
	$VBoxContainer/PanelContainer/HBoxContainer/Social.set_value(resources[RoomData.Resources.SOCIAL])
	$VBoxContainer/PanelContainer/HBoxContainer/Occupancy.set_value(resources[RoomData.Resources.OCCUPANCY])
	$VBoxContainer/PanelContainer/HBoxContainer2/Food.set_value(resources[RoomData.Resources.FOOD])
	return
