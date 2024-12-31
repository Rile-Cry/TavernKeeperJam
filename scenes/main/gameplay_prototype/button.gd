extends Button
@onready var move_player: AnimationPlayer = $"../MovePlayer"

func _ready() -> void:
	EventBus.submit_pressed.connect(on_submit)

func _on_pressed() -> void:
	move_player.play("move_to_bar")

func on_submit()->void:
	move_player.play("move_to_counter")
