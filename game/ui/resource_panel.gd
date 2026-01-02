class_name ResourcePanel
extends PanelContainer

func get_setter_for_resource_type(resource: RoomData.Resources) -> Callable:
	match resource:
		RoomData.Resources.FOOD:
			return %Food.set_value
		RoomData.Resources.OCCUPANCY:
			return %Occupancy.set_value
		RoomData.Resources.COMFORT:
			return %Comfort.set_value
		RoomData.Resources.LEISURE:
			return %Leisure.set_value
		RoomData.Resources.ROOM_TOKENS:
			return %Tokens.set_value
		RoomData.Resources.SOCIAL:
			return %Social.set_value
	# I miss exhaustiveness checks
	return func(): return
