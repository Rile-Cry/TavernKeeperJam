extends VBoxContainer

@onready var button := $HBoxContainer/MarginContainer/Button


func _craft() -> void:
	pass


func _ready() -> void:
	button.connect("pressed", _craft)
