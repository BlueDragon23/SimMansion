extends CanvasLayer

var options = []
var selected_option

signal accepted(selected)

func _ready():
	$VBoxContainer/ButtonGroup/Cancel.pressed.connect(on_cancel)
	$VBoxContainer/ButtonGroup/Accept.pressed.connect(on_accept)
	for option in options:
		var button = Button.new()
		button.text = option.name
		button.pressed.connect(on_select.bind(option))
		$VBoxContainer/RoomOptions.add_child(button)
	
func on_select(option: RoomData):
	self.selected_option = option
	
	
func on_cancel():
	queue_free()
	
func on_accept():
	accepted.emit(selected_option)
	queue_free()
