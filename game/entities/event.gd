class_name Event
extends Resource

@export var name: String
@export var description: String
# Names of rooms, one of which is required to finish the event
@export var rooms: Array[String]
# Resources required to finish the event
@export var resources: Dictionary[RoomData.Resources, int]
# Traits required to finish the event
@export var traits: Dictionary[RoomData.Traits, int]
