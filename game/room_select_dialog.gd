extends CanvasLayer

var options: Array[RoomData] = []
var selected_option
var available_money

signal accepted(selected)
signal canceled()

func _ready():
	$VBoxContainer/ButtonGroup/Cancel.pressed.connect(on_cancel)
	$VBoxContainer/ButtonGroup/Accept.pressed.connect(on_accept)
	for option in options:
		var button = Button.new()
		button.text = option.name
		if (option.cost > available_money):
			button.disabled = true
		button.pressed.connect(on_select.bind(option))
		$VBoxContainer/RoomOptions.add_child(button)
	
func on_select(option: RoomData):
	self.selected_option = option
	
	
func on_cancel():
	canceled.emit()
	queue_free()
	
func on_accept():
	accepted.emit(selected_option)
	queue_free()
