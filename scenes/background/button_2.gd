extends Button




func _on_pressed() -> void:
	EventBus.start_queue.emit()
