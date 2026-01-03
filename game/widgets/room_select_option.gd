class_name RoomSelectOption
extends PanelContainer

signal pressed()

@export var room: Room
var disabled
var selected = false

@onready var title = %Title
@onready var traits = %Traits
@onready var resources = %Resources
@onready var overlay = %Overlay

func _ready() -> void:
	title.text = "[b]" + room.name + "[/b]"
	if room.traits.size() > 1:
		traits.text = "[i]" + room.traits.map(func(t): RoomData.get_trait_name(t)).reduce(func(accum, t): return accum + ", " + t) + "[/i]"
	elif room.traits.size() == 1:
		traits.text = "[i]" + RoomData.get_trait_name(room.traits[0]) + "[/i]"
	resources.text = resource_text()

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed() and !disabled:
		pressed.emit()
		selected = true
		overlay.visible = true

func deselected() -> void:
	selected = false
	overlay.visible = false

func resource_text() -> String:
	var text = "[b]Resources[/b]\n[ul]"
	var any_resource = false
	if room.comfort > 0:
		any_resource = true
		text += "Comfort: " + str(room.comfort) + "\n"
	if room.food > 0:
		any_resource = true
		text += "Food: " + str(room.food) + "\n"
	if room.leisure > 0:
		any_resource = true
		text += "Leisure: " + str(room.leisure) + "\n"
	if room.social > 0:
		any_resource = true
		text += "Social: " + str(room.social) + "\n"
	if room.occupancy > 0:
		any_resource = true
		text += "Occupancy: " + str(room.occupancy) + "\n"
	text += "[/ul]"
	if !any_resource:
		text = ""
	return text
