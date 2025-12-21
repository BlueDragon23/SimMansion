class_name State
extends Node

## This class tracks the main game state
## Hopefully everything that I would need to put in a save file basically
## Rooms in the house, events completed, current resources, etc.

## Emit the resource type, and the new resource value
signal resource_updated

var rooms: Array[Room]
var events: Array[int] # TODO: implement events
var resources: Dictionary[RoomData.Resources, int] = {}

func add_room(room: Room):
	rooms.append(room)
	update_resource(RoomData.Resources.ROOM_TOKENS, -1)
	update_resource(RoomData.Resources.ROOM_TOKENS, room.income)
	update_resource(RoomData.Resources.LEISURE, room.leisure)
	update_resource(RoomData.Resources.COMFORT, room.comfort)
	update_resource(RoomData.Resources.SOCIAL, room.social)
	update_resource(RoomData.Resources.FOOD, room.food)
	update_resource(RoomData.Resources.OCCUPANCY, room.occupancy)
	
	
func complete_event():
	pass
	
func update_resource(resource: RoomData.Resources, change: int):
	var current = resources.get(resource, 0)
	resources[resource] = current + change
	resource_updated.emit(resource, resources[resource])

func connect_for_resource_type(desired_resource: RoomData.Resources, listener: Callable):
	resource_updated.connect(func filter(type, new_value): 
		if (type == desired_resource): 
			listener.call(new_value))
