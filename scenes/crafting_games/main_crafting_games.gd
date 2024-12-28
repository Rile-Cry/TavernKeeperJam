extends Control

@onready var glass_top: TextureRect = $Items/Glass/GlassTop
@onready var tankard_top: TextureRect = $Items/Tankard/TankardTop
@onready var wineglass: TextureRect = $Items/Wineglass/Wineglass
@onready var dropdown_menu: AnimationPlayer = $DropdownMenu/DropdownMenu
@onready var wineglass_liquid: TextureRect = $Items/Wineglass/WineglassLiquid
@onready var glass_liquid: TextureRect = $Items/Glass/GlassLiquid
@onready var tankard_liquid: TextureRect = $Items/Tankard/TankardLiquid
@onready var current_crushed_potion_component: TextureRect = $Items/PotionComponent/CurrentCrushedPotionComponent
@onready var current_chopped_potion_component: TextureRect = $Items/PotionComponent/CurrentChoppedPotionComponent

var container_selected : bool = false

enum CONTAINERS { GLASS, TANKARD, WINEGLASS, NULL }

var CURRENT_CONTAINER : CONTAINERS = CONTAINERS.NULL

enum POTION_COMPONENTS { FIREPEPPERSEED, FORTIFLOWER, GALEGRASS, HARTROOT, NULL}
var CURRENT_POTION_COMPONENT : POTION_COMPONENTS = POTION_COMPONENTS.NULL
var CURRENT_CRUSHED_POTION_COMPONENT : POTION_COMPONENTS = POTION_COMPONENTS.NULL
var CURRENT_CHOPPED_POTION_COMPONENT : POTION_COMPONENTS = POTION_COMPONENTS.NULL
#var mortar_selected : bool = false
var mortar_has_potion_component : bool = false

var cutting_board_has_potion_component : bool = false

#@onready var glass_liquid_items = {
#	"gin": preload("res://assets/drink_craft_assets/plain_drinks/glass_gin_only.PNG"),
#	"ruined": preload("res://assets/drink_craft_assets/plain_drinks/glass_ruined_only.PNG"),
	
#}





func _on_tankard_pressed() -> void:
	if !container_selected:
		container_selected = true
		CURRENT_CONTAINER = CONTAINERS.TANKARD
		tankard_top.visible = true
		


func _on_glass_pressed() -> void:
	if !container_selected:
		container_selected = true
		CURRENT_CONTAINER = CONTAINERS.GLASS
		glass_top.visible = true


func _on_wineglass_pressed() -> void:
	if !container_selected:
		container_selected = true
		CURRENT_CONTAINER = CONTAINERS.WINEGLASS
		wineglass.visible = true




func _on_dropdown_menu_area_mouse_entered() -> void:
	if container_selected:
		dropdown_menu.play("fade_in")


func _on_dropdown_menu_area_mouse_exited() -> void:
	if container_selected:
		dropdown_menu.play("fade_out")


func _on_dropdown_menu_trash_pressed() -> void:
	container_selected = false
	dropdown_menu.play("fade_out")
	match CURRENT_CONTAINER:
		CONTAINERS.WINEGLASS:
			wineglass.visible = false
			wineglass_liquid.visible = false
		CONTAINERS.GLASS:
			glass_top.visible = false
			glass_liquid.visible = false
		CONTAINERS.TANKARD:
			tankard_top.visible = false
			tankard_liquid.visible = false
	CURRENT_CONTAINER = CONTAINERS.NULL


func _on_dropdown_menu_submit_pressed() -> void:
	print("submitted drink")


func _on_gin_pressed() -> void:
	print("gin selected")


func _on_cider_pressed() -> void:
	print("cider selected")


func _on_wine_pressed() -> void:
	print("wine selected")


func _on_ale_pressed() -> void:
	print("ale pressed")


func _on_beer_pressed() -> void:
	print("beer pressed")


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
				current_crushed_potion_component.texture = preload("res://assets/drink_craft_assets/potion_components/firepepperseed_crushed.PNG")
			POTION_COMPONENTS.FORTIFLOWER:
				current_crushed_potion_component.texture = preload("res://assets/drink_craft_assets/potion_components/fortiflower_crushed.PNG")
			POTION_COMPONENTS.GALEGRASS:
				current_crushed_potion_component.texture = preload("res://assets/drink_craft_assets/potion_components/galegrass_crushed.PNG")
			POTION_COMPONENTS.HARTROOT:
				current_crushed_potion_component.texture = preload("res://assets/drink_craft_assets/potion_components/hartroot_crushed.PNG")
		current_crushed_potion_component.visible = true
		
		CURRENT_CRUSHED_POTION_COMPONENT = CURRENT_POTION_COMPONENT
		CURRENT_POTION_COMPONENT = POTION_COMPONENTS.NULL
		
	elif CURRENT_CRUSHED_POTION_COMPONENT != POTION_COMPONENTS.NULL && container_selected:
		match CURRENT_CRUSHED_POTION_COMPONENT:
			POTION_COMPONENTS.FIREPEPPERSEED:
				print("added firepepper")
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
				current_chopped_potion_component.texture = preload("res://assets/drink_craft_assets/potion_components/firepepperseed_chopped.PNG")
			POTION_COMPONENTS.FORTIFLOWER:
				current_chopped_potion_component.texture = preload("res://assets/drink_craft_assets/potion_components/fortiflower_chopped.PNG")
			POTION_COMPONENTS.GALEGRASS:
				current_chopped_potion_component.texture = preload("res://assets/drink_craft_assets/potion_components/galegrass_chopped.PNG")
			POTION_COMPONENTS.HARTROOT:
				current_chopped_potion_component.texture = preload("res://assets/drink_craft_assets/potion_components/hartroot_chopped.PNG")
		current_chopped_potion_component.visible = true
		
		CURRENT_CHOPPED_POTION_COMPONENT = CURRENT_POTION_COMPONENT
		CURRENT_POTION_COMPONENT = POTION_COMPONENTS.NULL
	


func _on_chopped_potion_component_pressed() -> void:
	if CURRENT_CHOPPED_POTION_COMPONENT != POTION_COMPONENTS.NULL && container_selected:
		match CURRENT_CHOPPED_POTION_COMPONENT:
			POTION_COMPONENTS.FIREPEPPERSEED:
				print("added CUT firepepper")
			POTION_COMPONENTS.FORTIFLOWER:
				print("added CUT fortiflower")
			POTION_COMPONENTS.GALEGRASS:
				print("added CUT galegrass")
			POTION_COMPONENTS.HARTROOT:
				print("added CUT hartroot")
				
		
		
		current_chopped_potion_component.visible = false
		
		CURRENT_CHOPPED_POTION_COMPONENT = POTION_COMPONENTS.NULL
		CURRENT_POTION_COMPONENT = POTION_COMPONENTS.NULL
