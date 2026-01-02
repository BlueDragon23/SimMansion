class_name ResourceConnector
extends Resource

var state: State
var action_panel: ActionPanel
var resource_panel: ResourcePanel

func _init(state: State, action_panel: ActionPanel, resource_panel: ResourcePanel):
	self.state = state
	self.action_panel = action_panel
	self.resource_panel = resource_panel

func configure_connections():
	# Action panel needs to know if we can pay for rooms
	state.connect_for_resource_type(RoomData.Resources.ROOM_TOKENS, action_panel.update_tokens)
	# Resource panel should display resources
	state.connect_for_resource_type(RoomData.Resources.ROOM_TOKENS, resource_panel.get_setter_for_resource_type(RoomData.Resources.ROOM_TOKENS))
	state.connect_for_resource_type(RoomData.Resources.OCCUPANCY, resource_panel.get_setter_for_resource_type(RoomData.Resources.OCCUPANCY))
	state.connect_for_resource_type(RoomData.Resources.SOCIAL, resource_panel.get_setter_for_resource_type(RoomData.Resources.SOCIAL))
	state.connect_for_resource_type(RoomData.Resources.COMFORT, resource_panel.get_setter_for_resource_type(RoomData.Resources.COMFORT))
	state.connect_for_resource_type(RoomData.Resources.LEISURE, resource_panel.get_setter_for_resource_type(RoomData.Resources.LEISURE))
	state.connect_for_resource_type(RoomData.Resources.FOOD, resource_panel.get_setter_for_resource_type(RoomData.Resources.FOOD))
	# TODO: include traits somehow too?
