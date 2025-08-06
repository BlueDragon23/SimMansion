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
static var KITCHEN = new("Kitchen", 10, ["Commercial Kitchen"], {Resources.FOOD: 2})
static var COMMERCIAL_KITCHEN = new("Commercial Kitchen", 30)
static var BEDROOM = new("Bedroom", 10, ["Nursery", "Bunk Room", "Bedroom Suite"], {Resources.OCCUPANCY: 1})
static var DINING_ROOM = new("Dining Room", 10, [], {Resources.FOOD: 1, Resources.SOCIAL: 2})
static var OFFICE = new("Office", 10, [], {Resources.MONEY: 3})
static var NURSERY = new("Nursery", 50, [], {Resources.OCCUPANCY: 1})
static var BUNK_ROOM = new("Bunk Room", 50, [], {Resources.OCCUPANCY: 2})
static var SUITE = new("Bedroom Suite", 50, [], {Resources.OCCUPANCY: 1, Resources.COMFORT: 1})
static var SWIMMING_POOL = new("Swimming Pool", 10, ["Lap Pool", "Infinity Pool"])
static var LAP_POOL = new("Lap Pool", 10, [])
static var INFINITY_POOL = new("Infinity Pool", 10, [])
static var CLASSROOM = new("Classroom", 20, ["Lecture Hall"])
static var LECTURE_HALL = new("Lecture Hall", 100, [])

static var ROOM_LOOKUP: Dictionary[String, RoomData] = {
	"Kitchen": KITCHEN,
	"Commercial Kitchen": COMMERCIAL_KITCHEN,
	"Bedroom": BEDROOM,
	"Dining Room": DINING_ROOM,
	"Office": OFFICE,
	"Nursery": NURSERY,
	"Bunk Room": BUNK_ROOM,
	"Bedroom Suite": SUITE,
	"Swimming Pool": SWIMMING_POOL,
	"Lap Pool": LAP_POOL,
	"Infinity Pool": INFINITY_POOL,
	"Classroom": CLASSROOM,
	"Lecture Hall": LECTURE_HALL
}
