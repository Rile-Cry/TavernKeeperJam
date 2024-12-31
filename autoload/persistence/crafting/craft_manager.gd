extends Node

var ingredients := {}
var recipes := {}

var _ingredient_path := "res://components/crafting/items"
var _recipe_path := "res://components/crafting/recipes"


func craft(ingredient_list: Array[String], process: TavernItem.PROCESS_TYPE) -> TavernItem:
	var craft_list : Array[TavernItem] = []
	for ingredient in ingredient_list:
		craft_list.append(ingredients[ingredient])
	
	if _recipe_check(craft_list, process) == null:
		return null
	return _recipe_check(craft_list, process).result


func _recipe_check(ingredient_list: Array[TavernItem], process: TavernItem.PROCESS_TYPE) -> TavernRecipe:
	for recipe in recipes:
		
		if recipes[recipe].process_method == process:
			#print("star checking has all ----------------------------")
			if has_all(recipes[recipe].ingredients, ingredient_list) and recipes[recipe].ingredients.size() == ingredient_list.size():
				return recipes[recipe]
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

func has_all(array1 : Array[TavernItem], array2: Array[TavernItem] ) ->bool:
	var array_contains : bool = false
	for item in array1:
		array_contains = false
		#print(item.ingredient_name)
		for item2 in array2:
			if item != null && item2 !=null :
				if item.ingredient_name == item2.ingredient_name:
					#print(item.ingredient_name + " == " + item2.ingredient_name)
					array_contains = true
		if !array_contains:
			#print("didnt find correct item")
			return false
			
	#print("found correct item")
	return true


func possible_to_continue_recipe(ingredient_list: Array[String])->bool:
	var craft_list : Array[TavernItem] = []
	for ingredient in ingredient_list:
		craft_list.append(ingredients[ingredient])
	
	for recipe in recipes:
		
		
	
		if has_all(craft_list, recipes[recipe].ingredients) and recipes[recipe].ingredients.size() > ingredient_list.size():
			return true
	
	return false

func get_recipe(item: TavernItem)-> TavernRecipe:
	
	return recipes[item.ingredient_name]
	
	





func _ready() -> void:
	print("starting...")
	_load_ingredients()
	print("ingredients loaded...")
	_load_recipes()
	print("recipes loaded...")
