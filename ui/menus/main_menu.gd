extends Control

@export_file(".tscn") var next_scene: String = ""

@onready var _new_game_button := $VBoxContainer/NewGame

@onready var _new_game_panel := $NewGamePanel
@onready var _name_text := $NewGamePanel/MarginContainer/VBoxContainer/NameBox/NameInput
@onready var _back_button := $NewGamePanel/MarginContainer/VBoxContainer/Buttons/Back
@onready var _start_button := $NewGamePanel/MarginContainer/VBoxContainer/Buttons/Start


func _ready() -> void:
	# Main Menu Connects
	_new_game_button.connect("pressed", _open_new_game)
	
	# New Game Panel Connects
	_start_button.connect("pressed", _start_new_game)
	_back_button.connect("pressed", _close_new_game)


func _open_new_game() -> void:
	_new_game_panel.show()

func _start_new_game() -> void:
	GameGlobals.set_global_variable("name", _name_text.text)
	Dialogic.VAR.PlayerName = _name_text.text
	SceneTransitionManager.transition_to_scene(next_scene)

func _close_new_game() -> void:
	_new_game_panel.hide()
