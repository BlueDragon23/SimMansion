class_name State
extends Node

## This class tracks the main game state
## Hopefully everything that I would need to put in a save file basically
## Rooms in the house, events completed, current resources, etc.

## Emit the resource type, and the new resource value
signal resource_updated
## Emit an event that events have changed
signal event_updated
signal event_completed

var rooms: Array[Room]
var events: Array[Event]
## How many resources are provided by rooms
var resources: Dictionary[RoomData.Resources, int] = {}
## How many rooms have a given trait
var traits: Dictionary[RoomData.Traits, int] = {}

func add_room(room: Room):
	rooms.append(room)
	update_resource(RoomData.Resources.ROOM_TOKENS, -1)
	update_resource(RoomData.Resources.ROOM_TOKENS, room.income)
	update_resource(RoomData.Resources.LEISURE, room.leisure)
	update_resource(RoomData.Resources.COMFORT, room.comfort)
	update_resource(RoomData.Resources.SOCIAL, room.social)
	update_resource(RoomData.Resources.FOOD, room.food)
	update_resource(RoomData.Resources.OCCUPANCY, room.occupancy)
	for t in room.traits:
		traits.set(t, traits.get(t, 0) + 1)
	check_events_completed()

func replace_room(new_room: Room, old_room: Room):
	self.rooms.set(self.rooms.find(old_room), new_room)
	update_resource(RoomData.Resources.ROOM_TOKENS, -1)
	update_resource(RoomData.Resources.ROOM_TOKENS, new_room.income - old_room.income)
	update_resource(RoomData.Resources.LEISURE, new_room.leisure - old_room.leisure)
	update_resource(RoomData.Resources.COMFORT, new_room.comfort - old_room.comfort)
	update_resource(RoomData.Resources.SOCIAL, new_room.social - old_room.social)
	update_resource(RoomData.Resources.FOOD, new_room.food - old_room.food)
	update_resource(RoomData.Resources.OCCUPANCY, new_room.occupancy - old_room.occupancy)
	for t in new_room.traits:
		traits.set(t, traits.get(t, 0) + 1)
	for t in old_room.traits:
		traits.set(t, traits.get(t, 0) - 1)
	check_events_completed()
	
func add_event(event: Event):
	events.append(event)
	event_updated.emit()
	
func check_events_completed():
	var finished_events: Array = []
	for event in events:
		var is_event_completed = true
		for r in event.resources:
			if self.resources.get(r, 0) < event.resources.get(r, 0):
				is_event_completed = false
				break
		for t in event.traits:
			if self.traits.get(t, 0) < event.traits.get(t, 0):
				is_event_completed = false
				break
		if is_event_completed:
			event_completed.emit(event)
			finished_events.append(event)
			print("Finished event " + event.name)
	events = events.filter(func(e): return !(e in finished_events))
	if finished_events.size() > 0:
		event_updated.emit()
	
func update_resource(resource: RoomData.Resources, change: int):
	var current = resources.get(resource, 0)
	resources[resource] = current + change
	resource_updated.emit(resource, resources[resource])

func connect_for_resource_type(desired_resource: RoomData.Resources, listener: Callable):
	resource_updated.connect(func filter(type, new_value): 
		if (type == desired_resource): 
			listener.call(new_value))
