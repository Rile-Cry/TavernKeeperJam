extends Node

var ingredients := {}
var recipes := {}

var _ingredient_path := "res://components/crafting/items"
var _recipe_path := "res://components/crafting/recipes"


func craft(ingredient_list: Array[String], process: TavernItem.PROCESS_TYPE) -> TavernItem:
	var craft_list := []
	for ingredient in ingredient_list:
		craft_list.append(ingredients[ingredient])
	return _recipe_check(craft_list, process).result


func _recipe_check(ingredient_list: Array[TavernItem], process: TavernItem.PROCESS_TYPE) -> TavernRecipe:
	for recipe in recipes:
		if recipes[recipe].process_method == process:
			if recipes[recipe].ingredients.has_all(ingredient_list) and recipes[recipe].ingredients.size() == ingredient_list.size():
				return recipe
	return null

func _load_ingredients() -> void:
	var temp_ingredients := _load_dir(_ingredient_path)
	for ingredient in temp_ingredients:
		var ingredient_resource : TavernItem = ResourceLoader.load(_ingredient_path + "/" + ingredient, "TavernItem")
		var ingredient_name : String = ingredient_resource.ingredient_name
		ingredients[ingredient_name] = ingredient_resource
	

func _load_recipes() -> void:
	var temp_recipes := _load_dir(_recipe_path)
	for recipe in temp_recipes:
		var recipe_resource : TavernRecipe = ResourceLoader.load(_recipe_path + "/" + recipe, "TavernRecipe")
		var recipe_name : String = recipe_resource.result.ingredient_name
		recipes[recipe_name] = recipe_resource

func _load_dir(path: String, sub_dir: String = "") -> Array[String]:
	var dir = DirAccess.open(path + sub_dir)
	var list : Array[String] = []
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				list += _load_dir(path, sub_dir + "/" + file_name)
			else:
				list.append(sub_dir + "/" + file_name)
			file_name = dir.get_next()
		return list
	else:
		return []


func _ready() -> void:
	_load_ingredients()
	_load_recipes()
