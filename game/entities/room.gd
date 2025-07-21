class_name Room
extends Area2D

const room_scene: PackedScene = preload("res://game/entities/room.tscn")

enum Traits {
	EDUCATIONAL,
	ARTISTIC,
	ATHLETIC,
	BEDROOM,
	FOOD
}

var room_data: RoomData

static func create_room(room_data: RoomData) -> Room:
	var new_room: Room = room_scene.instantiate()
	new_room.room_data = room_data
	return new_room
	
func _ready():
	$Sprite2D/Label.text = room_data.name
