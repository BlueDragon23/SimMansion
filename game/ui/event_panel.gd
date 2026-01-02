extends PanelContainer

@onready var events = %Events

var event_ui_template = preload("res://game/entities/event_ui.tscn")
# fetch events from state
var get_events: Callable

func redraw_events():
	events.get_children().map(events.remove_child)
	for e: Event in get_events.call():
		var event_scene = event_ui_template.instantiate()
		event_scene.name = e.name
		event_scene.event = e
		events.add_child(event_scene)
