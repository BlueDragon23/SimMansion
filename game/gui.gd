extends CanvasLayer

@onready var game_window: GameWindow = %GameWindow
@onready var event_panel = %EventPanel
@onready var resource_panel = %ResourcePanel
@onready var action_panel = %ActionPanel

var selected_room: Room = null
var placing_room: Room = null
var placing_overlay = null
var state := State.new()
var resource_connector: ResourceConnector

func _ready():
	# Initial house stuff. Maybe just for testing?
	add_room(Vector2(0, 0), Rooms.bedroom)
	add_room(Vector2(500, 0), Rooms.office)
	add_room(Vector2(1100, 0), Rooms.swimming_pool)
	add_room(Vector2(0, 600), Rooms.ceramics_studio)
	resource_connector = ResourceConnector.new(state, action_panel, resource_panel)
	resource_connector.configure_connections()
	# reset money because I pay for my initial rooms lol
	state.update_resource(RoomData.Resources.ROOM_TOKENS, 10)
	# TODO: move to event connector
	event_panel.get_events = func(): return state.events
	state.event_updated.connect(event_panel.redraw_events)
	state.add_event(Events.creative_workshop)
	state.add_event(Events.let_there_be_life)
	state.add_event(Events.pool_party)
	
	action_panel.update_game_state.connect(state.update_game_state)
	game_window.room_selected.connect(func(r): self.selected_room = r)
	game_window.room_deselected.connect(func(_r): self.selected_room = null)

func start_room_placement(adding_room: Room):
	state.game_state = State.GameState.PLACING
	self.placing_room = adding_room
	var placing_overlay = preload("res://game/widgets/placing_room.tscn").instantiate()
	placing_overlay.add_child(RoomUI.create_room(adding_room))
	self.placing_overlay = placing_overlay
	add_child(placing_overlay)
	placing_overlay.on_click.connect(add_room.bind(adding_room))

func add_room(position: Vector2, added_room: Room):
	if game_window.is_valid_placement(Rect2(position, Vector2(500, 500))):
		state.game_state = State.GameState.RUNNING
		if self.placing_overlay != null:
			remove_child(self.placing_overlay)
			self.placing_overlay = null
		state.add_room(added_room)
		game_window.add_room(added_room, position)
		AvailableRooms.refresh_available_rooms()

func upgrade_room(upgraded_room: Room):
	# TODO: there's definitely race conditions on selecting a different room
	state.replace_room(upgraded_room, selected_room)
	game_window.replace_room(upgraded_room, selected_room)
