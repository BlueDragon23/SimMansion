extends HBoxContainer

@export_file var icon
@export var resource_name: String
var value = 0

func _ready():
	if icon:
		$Icon.texture = load(icon)
	$Name.text = resource_name
	$Value.text = str(value)
	
func set_value(_value: int):
	value = _value
	$Value.text = str(_value)
	
func modify_value(_change: int):
	value += _change
	$Value.text = str(value)
