class_name TavernItem extends Resource

enum PROCESS_TYPE {
	CHOPPING,
	BOILING,
	GRINDING,
	DISTILLING,
	MIXING
}

@export var ingredient_name: String
@export var texture: Texture2D
@export var cost: int
@export var quality: int
@export var description: String
@export var processing: Array[PROCESS_TYPE]
@export var fame_required: int
