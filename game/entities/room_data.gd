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
