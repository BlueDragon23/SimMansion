class_name AvailableRooms
extends Resource

static var current_available_rooms = [Rooms.kitchen, Rooms.dining_room, Rooms.bedroom]

static func get_available_rooms() -> Array[Room]:
	return current_available_rooms

static func refresh_available_rooms():
	# TODO: consider rooms that are already in the house
	var valid_rooms = Rooms.all.filter(func (r: Room): return r.is_base_room)
	valid_rooms.shuffle()
	current_available_rooms = valid_rooms.slice(0, 3)
