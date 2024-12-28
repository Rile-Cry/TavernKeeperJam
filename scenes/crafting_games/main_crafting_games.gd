extends Control

@onready var glass_top: TextureRect = $Items/Glass/GlassTop
@onready var tankard_top: TextureRect = $Items/Tankard/TankardTop
@onready var wineglass: TextureRect = $Items/Wineglass/Wineglass
@onready var dropdown_menu: AnimationPlayer = $DropdownMenu/DropdownMenu
@onready var current_crushed_potion_component: TextureRect = $Items/PotionComponent/CurrentCrushedPotionComponent
@onready var current_chopped_potion_component: TextureRect = $Items/PotionComponent/CurrentChoppedPotionComponent
@onready var liquid: TextureRect = $Items/Liquid

#toggled buttons
@onready var firepepperseed: GlowyButtonToggle = $Firepepperseed
@onready var fortiflower: GlowyButtonToggle = $Fortiflower
@onready var galegrass: GlowyButtonToggle = $Galegrass
@onready var hartroot: GlowyButtonToggle = $Hartroot



var container_selected : bool = false

enum CONTAINERS { GLASS, TANKARD, WINEGLASS, NULL }

var CURRENT_CONTAINER : CONTAINERS = CONTAINERS.NULL

enum POTION_COMPONENTS { FIREPEPPERSEED, FORTIFLOWER, GALEGRASS, HARTROOT, NULL}
var CURRENT_POTION_COMPONENT : POTION_COMPONENTS = POTION_COMPONENTS.NULL
var CURRENT_CRUSHED_POTION_COMPONENT : POTION_COMPONENTS = POTION_COMPONENTS.NULL
var CURRENT_CHOPPED_POTION_COMPONENT : POTION_COMPONENTS = POTION_COMPONENTS.NULL

var mortar_has_potion_component : bool = false

var cutting_board_has_potion_component : bool = false
const LIGHT_BLINK = preload("res://shaders/crafting_game/brigthen.tres")
const LIGHT_CONST = preload("res://shaders/crafting_game/light_up.tres")

const EMPTY_DRINK = preload("res://components/crafting/items/ingredients/empty_drink.tres")
const RUINED_DRINK = preload("res://components/crafting/items/ingredients/ruined_drink.tres")
const GIN = preload("res://components/crafting/items/ingredients/gin.tres")
const CIDER = preload("res://components/crafting/items/ingredients/cider.tres")
const WINE = preload("res://components/crafting/items/ingredients/wine.tres")
const ALE = preload("res://components/crafting/items/ingredients/ale.tres")
const BEER = preload("res://components/crafting/items/ingredients/beer.tres")
const GLASS_WITH_FIREPEPPER_GIN = preload("res://components/crafting/items/ingredients/glass_with_firepepper_gin.tres")
const TANKARD_WITH_FIREPEPPER_ALE = preload("res://components/crafting/items/ingredients/tankard_with_firepepper_ale.tres")
const TANKARD_WITH_FIREPEPPER_BEER = preload("res://components/crafting/items/ingredients/tankard_with_firepepper_beer.tres")
const TANKARD_WITH_FIREPEPPER_CIDER = preload("res://components/crafting/items/ingredients/tankard_with_firepepper_cider.tres")
const WINEGLASS_WITH_FIREPEPPER_WINE = preload("res://components/crafting/items/ingredients/wineglass_with_firepepper_wine.tres")
@onready var drink_results = {
	GIN:preload("res://assets/drink_craft_assets/plain_drinks/glass_gin_only.PNG"),
	WINE:preload("res://assets/drink_craft_assets/plain_drinks/wineglass_wine_only.PNG"),
	CIDER:preload("res://assets/drink_craft_assets/plain_drinks/tankard_with_cider.PNG"),
	ALE:preload("res://assets/drink_craft_assets/plain_drinks/tankard_with_ale.PNG"),
	BEER:preload("res://assets/drink_craft_assets/plain_drinks/tankard_with_beer.PNG"),
	GLASS_WITH_FIREPEPPER_GIN:preload("res://assets/drink_craft_assets/fire_drinks/glass_fire_gin_only.PNG"),
	TANKARD_WITH_FIREPEPPER_ALE:preload("res://assets/drink_craft_assets/fire_drinks/tankard_with_fire_ale.PNG"),
	TANKARD_WITH_FIREPEPPER_BEER:preload("res://assets/drink_craft_assets/fire_drinks/tankard_with_fire_beer.PNG"),
	TANKARD_WITH_FIREPEPPER_CIDER:preload("res://assets/drink_craft_assets/fire_drinks/tankard_with_fire_cider.PNG"),
	WINEGLASS_WITH_FIREPEPPER_WINE:preload("res://assets/drink_craft_assets/fire_drinks/wineglass_fire_wine_only.PNG"),
	
	
	
}

var current_drink = EMPTY_DRINK

var current_ingredients : Array[String] = []


func _on_tankard_pressed() -> void:
	if !container_selected:
		current_ingredients.append("Tankard")
		container_selected = true
		CURRENT_CONTAINER = CONTAINERS.TANKARD
		tankard_top.visible = true
		


func _on_glass_pressed() -> void:
	if !container_selected:
		container_selected = true
		CURRENT_CONTAINER = CONTAINERS.GLASS
		glass_top.visible = true
		current_ingredients.append("Glass")


func _on_wineglass_pressed() -> void:
	if !container_selected:
		container_selected = true
		CURRENT_CONTAINER = CONTAINERS.WINEGLASS
		wineglass.visible = true
		current_ingredients.append("Wineglass")




func _on_dropdown_menu_area_mouse_entered() -> void:
	if container_selected:
		dropdown_menu.play("fade_in")


func _on_dropdown_menu_area_mouse_exited() -> void:
	if container_selected:
		dropdown_menu.play("fade_out")


func _on_dropdown_menu_trash_pressed() -> void:
	current_ingredients = []
	container_selected = false
	liquid.texture = null
	dropdown_menu.play("fade_out")
	match CURRENT_CONTAINER:
		CONTAINERS.WINEGLASS:
			wineglass.visible = false
		CONTAINERS.GLASS:
			glass_top.visible = false
		CONTAINERS.TANKARD:
			tankard_top.visible = false
	CURRENT_CONTAINER = CONTAINERS.NULL


func _on_dropdown_menu_submit_pressed() -> void:
	#print("submitted drink")
	EventBus.submit_pressed.emit()
	
	await get_tree().create_timer(1).timeout
	EventBus.give_item.emit(current_drink)
	
	
	current_ingredients = []
	container_selected = false
	liquid.texture = null
	dropdown_menu.play("fade_out")
	match CURRENT_CONTAINER:
		CONTAINERS.WINEGLASS:
			wineglass.visible = false
		CONTAINERS.GLASS:
			glass_top.visible = false
		CONTAINERS.TANKARD:
			tankard_top.visible = false
	CURRENT_CONTAINER = CONTAINERS.NULL
	


func _on_gin_pressed() -> void:
	if container_selected:
		current_ingredients.append("Gin")
		create_drink()


func _on_cider_pressed() -> void:
	if container_selected:
		current_ingredients.append("Cider")
		create_drink()


func _on_wine_pressed() -> void:
	if container_selected:
		current_ingredients.append("Wine")
		create_drink()


func _on_ale_pressed() -> void:
	if container_selected:
		current_ingredients.append("Ale")
		create_drink()


func _on_beer_pressed() -> void:
	if container_selected:
		current_ingredients.append("Beer")
		create_drink()


func _on_firepepperseed_pressed() -> void:
	CURRENT_POTION_COMPONENT = POTION_COMPONENTS.FIREPEPPERSEED


func _on_fortiflower_pressed() -> void:
	CURRENT_POTION_COMPONENT = POTION_COMPONENTS.FORTIFLOWER


func _on_galegrass_pressed() -> void:
	CURRENT_POTION_COMPONENT = POTION_COMPONENTS.GALEGRASS


func _on_hartroot_pressed() -> void:
	CURRENT_POTION_COMPONENT = POTION_COMPONENTS.HARTROOT


func _on_mortar_pressed() -> void:
	if CURRENT_POTION_COMPONENT != POTION_COMPONENTS.NULL && CURRENT_CRUSHED_POTION_COMPONENT == POTION_COMPONENTS.NULL:
		match CURRENT_POTION_COMPONENT:
			POTION_COMPONENTS.FIREPEPPERSEED:
				firepepperseed.button_pressed = false
				firepepperseed._on_pressed()
				current_crushed_potion_component.texture = preload("res://assets/drink_craft_assets/potion_components/firepepperseed_crushed.PNG")
			POTION_COMPONENTS.FORTIFLOWER:
				fortiflower.button_pressed = false
				fortiflower._on_pressed()
				current_crushed_potion_component.texture = preload("res://assets/drink_craft_assets/potion_components/fortiflower_crushed.PNG")
			POTION_COMPONENTS.GALEGRASS:
				galegrass.button_pressed = false
				galegrass._on_pressed()
				current_crushed_potion_component.texture = preload("res://assets/drink_craft_assets/potion_components/galegrass_crushed.PNG")
			POTION_COMPONENTS.HARTROOT:
				hartroot.button_pressed = false
				hartroot._on_pressed()
				current_crushed_potion_component.texture = preload("res://assets/drink_craft_assets/potion_components/hartroot_crushed.PNG")
		current_crushed_potion_component.visible = true
		
		CURRENT_CRUSHED_POTION_COMPONENT = CURRENT_POTION_COMPONENT
		CURRENT_POTION_COMPONENT = POTION_COMPONENTS.NULL
		
	elif CURRENT_CRUSHED_POTION_COMPONENT != POTION_COMPONENTS.NULL && container_selected:
		match CURRENT_CRUSHED_POTION_COMPONENT:
			POTION_COMPONENTS.FIREPEPPERSEED:
				current_ingredients.append("Crushed firepepper")
				create_drink()
				#print("added firepepper")
			POTION_COMPONENTS.FORTIFLOWER:
				print("added fortiflower")
			POTION_COMPONENTS.GALEGRASS:
				print("added galegrass")
			POTION_COMPONENTS.HARTROOT:
				print("added hartroot")
				
		
		
		current_crushed_potion_component.visible = false
		CURRENT_CRUSHED_POTION_COMPONENT = POTION_COMPONENTS.NULL

func _on_knife_pressed() -> void:
	if CURRENT_POTION_COMPONENT != POTION_COMPONENTS.NULL && CURRENT_CHOPPED_POTION_COMPONENT == POTION_COMPONENTS.NULL:
		match CURRENT_POTION_COMPONENT:
			POTION_COMPONENTS.FIREPEPPERSEED:
				firepepperseed.button_pressed = false
				firepepperseed._on_pressed()
				current_chopped_potion_component.texture = preload("res://assets/drink_craft_assets/potion_components/firepepperseed_chopped.PNG")
			POTION_COMPONENTS.FORTIFLOWER:
				fortiflower.button_pressed = false
				fortiflower._on_pressed()
				current_chopped_potion_component.texture = preload("res://assets/drink_craft_assets/potion_components/fortiflower_chopped.PNG")
			POTION_COMPONENTS.GALEGRASS:
				galegrass.button_pressed = false
				galegrass._on_pressed()
				current_chopped_potion_component.texture = preload("res://assets/drink_craft_assets/potion_components/galegrass_chopped.PNG")
			POTION_COMPONENTS.HARTROOT:
				hartroot.button_pressed = false
				hartroot._on_pressed()
				current_chopped_potion_component.texture = preload("res://assets/drink_craft_assets/potion_components/hartroot_chopped.PNG")
		current_chopped_potion_component.visible = true
		
		CURRENT_CHOPPED_POTION_COMPONENT = CURRENT_POTION_COMPONENT
		CURRENT_POTION_COMPONENT = POTION_COMPONENTS.NULL
	

func _on_chopped_potion_component_pressed() -> void:
	if CURRENT_CHOPPED_POTION_COMPONENT != POTION_COMPONENTS.NULL && container_selected:
		match CURRENT_CHOPPED_POTION_COMPONENT:
			POTION_COMPONENTS.FIREPEPPERSEED:
				current_ingredients.append("Chopped firepepper")
				create_drink()
			POTION_COMPONENTS.FORTIFLOWER:
				
				print("added CUT fortiflower")
			POTION_COMPONENTS.GALEGRASS:
				
				print("added CUT galegrass")
			POTION_COMPONENTS.HARTROOT:
				
				print("added CUT hartroot")
				
		
		
		current_chopped_potion_component.visible = false
		
		CURRENT_CHOPPED_POTION_COMPONENT = POTION_COMPONENTS.NULL
		CURRENT_POTION_COMPONENT = POTION_COMPONENTS.NULL

func create_drink()->void:
	var drink = CraftManager.craft(current_ingredients, TavernItem.PROCESS_TYPE.MIXING)
#	for string in current_ingredients:
#		print(string)
	if drink == null:
		match CURRENT_CONTAINER:
			CONTAINERS.WINEGLASS:
				liquid.texture = preload("res://assets/drink_craft_assets/plain_drinks/wineglass_ruined_only.PNG")
			CONTAINERS.GLASS:
				liquid.texture = preload("res://assets/drink_craft_assets/plain_drinks/glass_ruined_only.PNG")
			CONTAINERS.TANKARD:
				liquid.texture = preload("res://assets/drink_craft_assets/plain_drinks/tankard_ruined.PNG")
		current_drink = RUINED_DRINK
	else:
		liquid.texture = drink_results[drink]
		
		current_drink = drink


func _on_button_pressed() -> void:
	pass # Replace with function body.