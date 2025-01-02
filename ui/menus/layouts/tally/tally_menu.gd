extends CanvasLayer

@onready var end_of_day_label := $PanelContainer/MarginContainer/VBoxContainer/EoDTally
@onready var gained_fame_amount_label := $PanelContainer/MarginContainer/VBoxContainer/GainedFame/GainedFameAmount
@onready var fame_amount_label := $PanelContainer/MarginContainer/VBoxContainer/Fame/FameAmountLabel
@onready var next_day_button := $PanelContainer/MarginContainer/VBoxContainer/Button

func _ready() -> void:
	end_of_day_label.text = "End of day %s Tally" % GameGlobals.get_global_variable("days")
	gained_fame_amount_label.text = "1"
	GameGlobals.set_global_variable("fame", GameGlobals.get_global_variable("fame") + 1)
	fame_amount_label.text = "%s" % GameGlobals.get_global_variable("fame")
	
	next_day_button.pressed.connect(_on_next_day_button_pressed)


func _on_next_day_button_pressed() -> void:
	GameGlobals.set_global_variable("days", GameGlobals.get_global_variable("days") + 1)
	GlobalGameEvents.end_day()
	queue_free()
