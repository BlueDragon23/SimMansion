extends Control

## The tech tree determines which rooms may appear when buying new rooms
## There may be many options available at a given time
## Some options may only be unlocked by fulfilling certain requirements such as:
## - Completing an event
## - Having other rooms

## I need functionality to check whether a room is unlocked, based on the state of the house
func _ready() -> void:
	$TabContainer/Bedroom.room_roots.append_array([RoomData.BEDROOM])
	$TabContainer/Bedroom.render()
	$TabContainer/Craft.room_roots.append_array([RoomData.OFFICE])
	$TabContainer/Craft.render()
	$TabContainer/Leisure.room_roots.append_array([RoomData.DINING_ROOM, RoomData.SWIMMING_POOL])
	$TabContainer/Leisure.render()
	$TabContainer/Needs.room_roots.append_array([RoomData.KITCHEN, RoomData.CLASSROOM])
	$TabContainer/Needs.render()
