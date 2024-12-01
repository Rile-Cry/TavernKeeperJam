extends Control

@onready var time := $StatContainer/VBoxContainer/Time
@onready var day := $StatContainer/VBoxContainer/Day
@onready var fame := $StatContainer/VBoxContainer/Fame
@onready var money := $StatContainer/VBoxContainer/Money


func _replace_stat(text: String, stat: String) -> String:
	var splice = text.split(":")[0] + ":"
	stat = " {stat}".format({"stat": GameGlobals.get_global_variable(stat)})
	return splice + stat


func _ready() -> void:
	time.text = _replace_stat(time.text, "time")
	day.text = _replace_stat(day.text, "days")
	fame.text = _replace_stat(fame.text, "fame")
	money.text = _replace_stat(money.text, "money")
