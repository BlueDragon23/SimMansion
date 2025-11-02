class_name RoomUI
extends Area2D

signal room_selected

const room_scene: PackedScene = preload("res://game/entities/room_ui.tscn")

enum Traits {
	EDUCATIONAL,
	ARTISTIC,
	ATHLETIC,
	BEDROOM,
	FOOD
}

var room_data: Room

static func create_room(room_data: Room):
	var new_room
	if room_data.scene:
		new_room = room_data.scene.instantiate()
	else:
		new_room = room_scene.instantiate()
	new_room.room_data = room_data
	return new_room
	
func _ready():
	$Sprite2D/Label.text = room_data.name
	
func _input_event(_viewport: Viewport, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			print("Selected room " + room_data.name)
			room_selected.emit()
