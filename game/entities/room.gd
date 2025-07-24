class_name Room
extends Area2D

signal room_selected

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
	
func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			print("Selected room")
			room_selected.emit()
