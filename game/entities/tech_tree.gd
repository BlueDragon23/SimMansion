extends Control

## The tech tree determines which rooms may appear when buying new rooms
## There may be many options available at a given time
## Some options may only be unlocked by fulfilling certain requirements such as:
## - Completing an event
## - Having other rooms

@export var room_group: ResourceGroup

@onready var bedroom: TechSubtree = %Bedroom
@onready var craft: TechSubtree = %Craft
@onready var leisure: TechSubtree = %Leisure
@onready var needs: TechSubtree = %Needs

## I need functionality to check whether a room is unlocked, based on the state of the house
func _ready() -> void:
	var all_rooms: Array[Room] = []
	room_group.load_all_into(all_rooms)
	print(all_rooms)
	bedroom.draw_tree(all_rooms.filter(func (x): x.name == "Bedroom"))
	craft.draw_tree(all_rooms.filter(func (x): x.name == "Office"))
	leisure.draw_tree(all_rooms.filter(func (x): x.name == "Dining Room" or x.name == "Swimming Pool"))
	needs.draw_tree(all_rooms.filter(func (x): x.name == "Kitchen" or x.name == "Classroom"))
