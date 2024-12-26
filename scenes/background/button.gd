extends Button

@export var item : TavernItem



func _on_pressed() -> void:
	EventBus.give_item.emit(item)
