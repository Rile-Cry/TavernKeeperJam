extends CanvasLayer

@export var next_scene : PackedScene

@onready var version_label: Label = %VersionLabel

@onready var start_game_button: Button = %StartGameButton
@onready var enter_button := $MainMenu/StartSettings/MarginContainer/VBoxContainer/EnterButton
@onready var settings_button: Button = %SettingsButton
@onready var credits_button: Button = %CreditsButton
@onready var credits_back_button: Button = $MainMenu/Credits/MarginContainer/VBoxContainer/Back
@onready var exit_game_button: Button = %ExitGameButton

@onready var start_container := $MainMenu/StartSettings
@onready var credits_container := $MainMenu/Credits
@onready var player_name := $MainMenu/StartSettings/MarginContainer/VBoxContainer/HBoxContainer/PlayerName

	
func _ready() -> void:
	version_label.text = "v%s" % ProjectSettings.get_setting("application/config/version")
	MusicManager.play_music("menu")
	
	start_game_button.focus_neighbor_top = exit_game_button.get_path()
	exit_game_button.focus_neighbor_bottom = start_game_button.get_path()
	start_game_button.grab_focus()
	
	start_game_button.pressed.connect(_on_start_game_button_pressed)
	enter_button.pressed.connect(_on_enter_button_pressed)
	credits_button.pressed.connect(_on_credits_button_pressed)
	credits_back_button.pressed.connect(_on_credits_back_button_pressed)
	exit_game_button.pressed.connect(on_exit_game_button_pressed)


#region Signal callbacks
func _on_start_game_button_pressed() -> void:
	start_container.show()

func _on_enter_button_pressed() -> void:
	GameGlobals.set_player_name(player_name.text)
	MusicManager.stop_music()
	SceneTransitionManager.transition_to_scene(next_scene)

func _on_credits_button_pressed() -> void:
	credits_container.show()

func _on_credits_back_button_pressed() -> void:
	credits_container.hide()

func on_exit_game_button_pressed() -> void:
	get_tree().quit()


#endregion
