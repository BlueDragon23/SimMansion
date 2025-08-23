extends Area2D

signal room_selected

var room_data: Room
	
func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			print("Selected room " + room_data.name)
			room_selected.emit()
