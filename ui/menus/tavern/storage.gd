extends Control

@onready var _ingredient_list := $StoragePanel/VBoxContainer/IngredientList
@onready var _ingredient_panel := $IngredientPanel
@onready var _ingredient_name := $IngredientPanel/MarginContainer/VBoxContainer/IngredientName
@onready var _ingredient_texture := $IngredientPanel/MarginContainer/VBoxContainer/TextureRect
@onready var _process_list := $IngredientPanel/MarginContainer/VBoxContainer/ProcessContainer/ProcessList
@onready var _cost := $IngredientPanel/MarginContainer/VBoxContainer/CostContainer/CostLabel
@onready var _fame := $IngredientPanel/MarginContainer/VBoxContainer/FameContainer/FameLabel
@onready var _description := $IngredientPanel/MarginContainer/VBoxContainer/VBoxContainer/Description



func _setup() -> void:
	for item in GameGlobals.get_stock():
		var box = HBoxContainer.new()
		var button = AutoButton.new()
		var label = Label.new()
		
		button.text = item
		label.text = str(GameGlobals.get_stock_count(item))
		
		_ingredient_list.add_child(box)
		box.add_child(button)
		box.add_child(label)
		
		button.connect("auto_pressed", _update_popup)

func _update_popup(title: String) -> void:
	_ingredient_panel.show()
	var ingredient = IngredientList.retrieve_ingredient(title)
	_ingredient_name.text = ingredient.ingredient_name


func _ready() -> void:
	_setup()
