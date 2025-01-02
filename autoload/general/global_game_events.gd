extends Node

signal new_day

signal tutorial_bar
signal tutorial_counter
signal tutorial_start
signal tutorial_check

signal customer_left

func end_day() -> void:
	new_day.emit()


func _ready() -> void:
	Dialogic.signal_event.connect(_on_dialogic_signal_called)


func _on_dialogic_signal_called(arg) -> void:
	match arg:
		"move_to_bar":
			tutorial_bar.emit()
		"move_to_counter":
			tutorial_counter.emit()
		"tutorial_start":
			tutorial_start.emit()
