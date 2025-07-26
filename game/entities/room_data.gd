class_name RoomData
extends Object

## The possible resource types that can be acquired
enum Resources {
	## A static resource based on the house
	FOOD,
	## A static resource based on the house
	OCCUPANCY,
	## A static resource based on the house
	COMFORT,
	## A rate of income generation
	MONEY,
	## A resource that can be expended on new rooms/events
	SOCIAL
}

var name: String
var cost: int
var upgrades_to = []
var resources = {}
var traits = []

func _init(name, cost := 100, upgrades_to := [], resources := {}, traits := []) -> void:
	self.name = name
	self.cost = cost
	self.upgrades_to = upgrades_to
	self.resources = resources
	self.traits = traits

#TODO: I'll probably need to look these up by name at some point
#TODO: Add image paths for each room
static var KITCHEN = new("Kitchen", 10, [], {Resources.FOOD: 2})
static var BEDROOM = new("Bedroom", 10, ["Nursery", "Bunk Room", "Bedroom Suite"], {Resources.OCCUPANCY: 1})
static var DINING_ROOM = new("Dining Room", 10, [], {Resources.FOOD: 1, Resources.SOCIAL: 2})
static var OFFICE = new("Office", 10, [], {Resources.MONEY: 3})
static var NURSERY = new("Nursery", 50, [], {Resources.OCCUPANCY: 1})
static var BUNK_ROOM = new("Bunk Room", 50, [], {Resources.OCCUPANCY: 2})
static var SUITE = new("Bedroom Suite", 50, [], {Resources.OCCUPANCY: 1, Resources.COMFORT: 1})

static var ROOM_LOOKUP: Dictionary[String, RoomData] = {
	"Kitchen": RoomData.KITCHEN,
	"Bedroom": RoomData.BEDROOM,
	"Dining Room": RoomData.DINING_ROOM,
	"Office": RoomData.OFFICE,
	"Nursery": RoomData.NURSERY,
	"Bunk Room": RoomData.BUNK_ROOM,
	"Bedroom Suite": RoomData.SUITE
}
