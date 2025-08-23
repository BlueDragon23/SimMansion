class_name Room
extends Resource

@export var name: String
@export var cost: int = 10
@export var upgrades_to: Array[Room] = []
@export var traits: Array[String] = []
@export var scene: PackedScene
# Resources
@export var occupancy: int = 0
@export var food: int = 0
@export var comfort: int = 0
@export var income: int = 0
@export var social: int = 0
