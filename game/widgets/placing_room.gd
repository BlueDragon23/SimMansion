extends Node2D

signal on_click

func _process(delta: float) -> void:
	self.position = get_global_mouse_position()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		# TODO: hack. 
		# subtracting height of the header to align global mouse
		on_click.emit(get_global_mouse_position() - Vector2(0, 150))
