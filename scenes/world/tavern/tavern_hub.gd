extends Control

# Stat labels
@onready var time_label := $StatContainer/VBoxContainer/Time
@onready var day_label := $StatContainer/VBoxContainer/Day
@onready var fame_label := $StatContainer/VBoxContainer/Fame
@onready var money_label := $StatContainer/VBoxContainer/Money

# Button references
@onready var storage_button := $ActivityContainer/VBoxContainer/Stock
@onready var close_button := $ActivityContainer/VBoxContainer/CloseShop

# Private Functions
## Replaces the stat using the Global Variable
func _replace_stat(text: String, stat: String) -> String:
	var splice = text.split(":")[0] + ":"
	stat = " %s" % GameGlobals.get_global_variable(stat)
	return splice + stat

# Node and Extend Functions
func _ready() -> void:
	time_label.text = _replace_stat(time_label.text, "time")
	day_label.text = _replace_stat(day_label.text, "days")
	fame_label.text = _replace_stat(fame_label.text, "fame")
	money_label.text = _replace_stat(money_label.text, "money")
	
	if !GameGlobals.event_check["tutorial"]:
		Dialogic.start("tutorial")
	
	GlobalDayNightClock.connect("time_tick", _time_change)
	if !GlobalDayNightClock.running:
		GlobalDayNightClock.start(GameGlobals.get_global_variable("days"), 8)
		GlobalDayNightClock.in_game_speed = 10.0
	
	storage_button.connect("pressed", _open_storage)

# Signal Functions
func _time_change(day: int, hour: int, minute: int) -> void:
	day_label.text = _replace_stat(day_label.text, "day")
	time_label.text = _replace_stat(time_label.text, "time")

func _open_storage() -> void:
	$Storage.show()
