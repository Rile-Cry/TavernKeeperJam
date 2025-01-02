class_name GlowyButton
extends Button

const LIGHT_BLINK = preload("res://shaders/crafting_game/brigthen.tres")
const LIGHT_CONST = preload("res://shaders/crafting_game/light_up.tres")
@export var texture_node : TextureRect
var mouse_inside : bool = false

func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	pressed.connect(_on_pressed)

func _on_mouse_entered() -> void:
	mouse_inside = true
	texture_node.material = LIGHT_BLINK


func _on_mouse_exited() -> void:
	mouse_inside = false
	texture_node.material = null


func _on_pressed() -> void:
	texture_node.material = LIGHT_CONST
	release_focus()
	await get_tree().create_timer(0.2).timeout
	if mouse_inside:
		texture_node.material = LIGHT_BLINK
	else:
		texture_node.material = null
