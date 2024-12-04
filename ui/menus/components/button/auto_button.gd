class_name AutoButton extends Button

signal auto_pressed(title)

func _ready() -> void:
	connect("pressed", _button_pressed)


func _button_pressed() -> void:
	auto_pressed.emit(name)
