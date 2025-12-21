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
	## A static resource based on the house
	LEISURE,
	## A resource for buying/upgrading rooms
	ROOM_TOKENS,
	## A resource that can be expended on new rooms/events
	SOCIAL,
}

static func get_resource_name(resource: Resources):
	match resource:
		Resources.FOOD:
			return "Food"
		Resources.OCCUPANCY:
			return "Occupancy"
		Resources.COMFORT:
			return "Comfort"
		Resources.LEISURE:
			return "Leisure"
		Resources.ROOM_TOKENS:
			return "Tokens"
		Resources.SOCIAL:
			return "Social"

enum Traits {
	EDUCATIONAL,
	ARTISTIC,
	ATHLETIC,
	BEDROOM,
	FOOD
}

static func get_trait_name(t: Traits):
	match t:
		Traits.EDUCATIONAL:
			return "Educational"
		Traits.ARTISTIC:
			return "Artistic"
		Traits.ATHLETIC:
			return "Athletic"
		Traits.BEDROOM:
			return "Bedroom"
		Traits.FOOD:
			return "Food"
