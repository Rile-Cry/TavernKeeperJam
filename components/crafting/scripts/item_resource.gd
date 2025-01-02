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
@export var sell_cost: int ## Only for sellable items
@export var quality: int
@export var description: String
@export var processing: Array[PROCESS_TYPE]
@export var fame_required: int
@export var fame_given: int ## Only for result items
