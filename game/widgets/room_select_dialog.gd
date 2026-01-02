extends CanvasLayer

var title: String = ""
var options: Array[Room] = []
var selected_option: Room
var available_money: int

signal accepted(selected: Room)
signal canceled()

func _ready():
	%Cancel.pressed.connect(on_cancel)
	%Accept.pressed.connect(on_accept)
	%Accept.disabled = true
	%Title.text = title
	for option in options:
		var button = Button.new()
		button.text = option.name
		if (option.cost > available_money):
			button.disabled = true
		button.pressed.connect(on_select.bind(option))
		%RoomOptions.add_child(button)
	
func on_select(option: Room):
	self.selected_option = option
	%Accept.disabled = false
	
	
func on_cancel():
	canceled.emit()
	queue_free()
	
func on_accept():
	if selected_option != null:
		accepted.emit(selected_option)
		queue_free()
