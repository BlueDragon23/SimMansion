class_name RoomData
extends Object

var name: String
var upgrades_to = []
var resources = []
var traits = []

func _init(name, upgrades_to, resources, traits) -> void:
	self.name = name
	self.upgrades_to = upgrades_to
	self.resources = resources
	self.traits = traits

#TODO: I'll probably need to look these up by name at some point
#TODO: Add image paths for each room
static var KITCHEN = new("Kitchen", [], [], [])
static var BEDROOM = new("Bedroom", [], [], [])
static var DINING_ROOM = new("Dining Room", [], [], [])
