class_name Ingredient extends Resource

enum ProcessTypes {
	CHOPPING,
	BOILING,
	GRINDING,
	DISTILLING,
	MIXING
}

@export var ingredient_name: String
@export var texture: Texture2D
@export var cost: int
@export var description: String
@export var processing: Array[ProcessTypes]
@export var fame_required: int
