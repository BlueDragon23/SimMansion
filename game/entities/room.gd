class_name Room
extends Resource

@export var name: String
@export var cost: int = 10
@export var upgrades_to: Array[Room] = []
@export var traits: Array[RoomData.Traits] = []
@export var scene: PackedScene
@export var is_base_room: bool
# Resources
@export var occupancy: int = 0
@export var food: int = 0
@export var comfort: int = 0
@export var income: int = 0
@export var social: int = 0
@export var leisure: int = 0
