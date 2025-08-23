class_name TechSubtree
extends Control

@export var title: String

func _ready() -> void:
	$VBoxContainer/Heading.text = title

func draw_tree(room_roots: Array[Room]) -> void:
	# Render all rooms in a tree. Nodes may have multiple parents, just to keep things fun
	var pending = room_roots.duplicate()
	var pending_connections = {}
	var next: Room = pending.pop_back()
	print(next)
	while next != null:
		print("Adding node " + next.name)
		render_node(next)
		pending_connections[next.name] = next.upgrades_to.map(func(x): x.name)
		pending.append_array(next.upgrades_to)
		next = pending.pop_back()
	for source in pending_connections:
		if pending_connections[source].size() == 0:
			$VBoxContainer/GraphEdit.get_node(source).set_slot_enabled_right(0, false)
		for target in pending_connections[source]:
			$VBoxContainer/GraphEdit.get_node(target).set_slot_enabled_left(0, true)
			$VBoxContainer/GraphEdit.connect_node(source, 0, target, 0)
	$VBoxContainer/GraphEdit.arrange_nodes()
	

func render_node(room: Room):
	var node = GraphNode.new()
	node.add_child(Control.new())
	node.set_slot_enabled_left(0, false)
	node.set_slot_enabled_right(0, true)
	node.name = room.name
	node.title = room.name
	$VBoxContainer/GraphEdit.add_child(node)
