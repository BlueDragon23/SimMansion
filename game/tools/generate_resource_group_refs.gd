@tool
extends EditorScript

func _run() -> void:
	generate_code(preload("res://game/entities/all_rooms.tres"), "Room", "res://game/generated/rooms.gd")

func generate_code(resource_group: ResourceGroup, type: String, output: String):
	var items = resource_group.load_all()
	var items_str = "\n".join(items.map(func(item: Variant):
		return 'static var {id}: {type} = load("{path}")'.format({"id": item.name.replace(" ", "_").to_lower(), "path": item.resource_path, type: type})))
	var all_str = ", ".join(items.map(func(item: Variant): return item.name.replace(" ", "_").to_lower()))

	var script_content = \
"""
# This file was auto-generated
class_name {class_name}
extends RefCounted

{items}

static var all: Array[{type}] = [{all}]

""".format({"items": items_str, "all": all_str, "type": type, "class_name": type + "s"})

	print(script_content)

	var script = GDScript.new()
	script.source_code = script_content
	ResourceSaver.save(script, output)
	
