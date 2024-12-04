class_name IngredientList

const _LIST := {
	"Hartroot": "res://components/ingredients/hartroo.tres"
}

static func retrieve_ingredient(ingredient: String) -> Ingredient:
	return _LIST[ingredient]
