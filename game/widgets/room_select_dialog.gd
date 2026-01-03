extends CanvasLayer

var title: String = ""
var options: Array[Room] = []
var selected_option: Room
var selected_option_scene: RoomSelectOption
var available_money: int
var room_select_option_template = preload("res://game/widgets/room_select_option.tscn")

@onready var accept_button = %Accept

signal accepted(selected: Room)
signal canceled()

func _ready():
	accept_button.disabled = true
	%Title.text = title
	for option in options:
		var option_scene: RoomSelectOption = room_select_option_template.instantiate()
		option_scene.room = option
		if (option.cost > available_money):
			print(option.name + " is too expensive")
			# TODO: UI state for too expensive rooms
			option_scene.disabled = true
		option_scene.pressed.connect(on_select.bind(option, option_scene))
		%RoomOptions.add_child(option_scene)
	
func on_select(option: Room, option_scene: RoomSelectOption):
	if self.selected_option_scene != null:
		self.selected_option_scene.deselected()
	self.selected_option = option
	self.selected_option_scene = option_scene
	accept_button.disabled = false
	
	
func on_cancel():
	canceled.emit()
	queue_free()
	
func on_accept():
	if selected_option != null:
		accepted.emit(selected_option)
		queue_free()
