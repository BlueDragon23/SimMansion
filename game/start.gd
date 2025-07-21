extends Button


func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			get_node("/root/Main/Title").queue_free()
			var gui = preload("res://game/gui.tscn").instantiate()
			get_node("/root/Main").add_child(gui)
	
