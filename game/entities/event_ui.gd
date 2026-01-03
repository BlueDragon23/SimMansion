class_name EventUi
extends PanelContainer

@export var event: Event
@onready var event_name: RichTextLabel = %Name
@onready var description: RichTextLabel = %Description
@onready var rooms: RichTextLabel = %Rooms
@onready var resources: RichTextLabel = %Resources
@onready var traits: RichTextLabel = %Traits

func _ready() -> void:
	event_name.text = "[b]" + event.name + "[/b]"
	description.text = event.description
	if event.rooms.size() > 0:
		rooms.append_text("[b]One of Rooms:[/b]")
		rooms.newline()
		var room_names = event.rooms.reduce(func(accum, name): return accum + "\n" + name)
		rooms.append_text("[ul]" + room_names + "[/ul]")
		
	for resource in event.resources:
		var value = event.resources.get(resource, 0)
		if value > 0:
			resources.newline()
			resources.append_text(RoomData.get_resource_name(resource) + ": " + str(value))
			
	for t in event.traits:
		var value = event.traits.get(t, 0)
		if value > 0:
			traits.newline()
			traits.append_text(RoomData.get_trait_name(t) + ": " + str(value))
