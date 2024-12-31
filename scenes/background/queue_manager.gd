class_name QueueManager
extends Node
@onready var npc_animation: AnimationPlayer = $"../NpcAnimation"

const NPC_CUSTOMER = preload("res://components/npc/npc_customer.tscn")
@onready var characters: Control = $"../Characters"
@onready var game_manager: GameManager = $"../GameManager"

var npc_array : Array[CustomerResource] =[
 preload("res://custom_resources/customers/disgruntled_farmer.tres"),
 preload("res://custom_resources/customers/frazzled_weaver.tres"),
 preload("res://custom_resources/customers/wandering_drunkard.tres"),

]


var npc_texture_array : Array[Texture2D] = [
	#preload("res://assets/character_sprites/crypticwanderer.PNG"),
	#preload("res://assets/character_sprites/disgruntledfarmer.PNG"),
	#preload("res://assets/character_sprites/frazzledweaver.PNG"),
	#preload("res://assets/character_sprites/hildegard.PNG"),
	#preload("res://assets/character_sprites/roguishsmuggler.PNG"),
	#preload("res://assets/character_sprites/wanderingdrunkard.PNG"),
	preload("res://assets/character_sprites/disgruntledfarmer.PNG"),
	preload("res://assets/character_sprites/frazzledweaver.PNG"),
	preload("res://assets/character_sprites/wanderingdrunkard.PNG"),
	preload("res://assets/character_sprites/roguishsmuggler.PNG"),
	
]



@export var npc_amount : int = -1

@export var available_dishes : Array[TavernItem]
const ALE = preload("res://components/crafting/items/ingredients/ale.tres")
const TANKARD_WITH_STRENGTH_ALE = preload("res://components/crafting/items/ingredients/tankard_with_strength_ale.tres")
const GIN = preload("res://components/crafting/items/ingredients/gin.tres")
const BEER = preload("res://components/crafting/items/ingredients/beer.tres")
const GLASS_WITH_STRENGTH_GIN = preload("res://components/crafting/items/ingredients/glass_with_strength_gin.tres")
const TANKARD_WITH_SWIFTNESS_ALE = preload("res://components/crafting/items/ingredients/tankard_with_swiftness_ale.tres")
const WINE = preload("res://components/crafting/items/ingredients/wine.tres")
const WINEGLASS_WITH_SWIFTNESS_WINE = preload("res://components/crafting/items/ingredients/wineglass_with_swiftness_wine.tres")
const WINEGLASS_WITH_STRENGTH_WINE = preload("res://components/crafting/items/ingredients/wineglass_with_strength_wine.tres")



const ROGUISH_SMUGGLER = preload("res://custom_resources/customers/roguish_smuggler.tres")
var remaining_customers : int
var current_customer : Customer

func _ready() -> void:
	if GlobalVar.fame >= 8:
		npc_array.append(ROGUISH_SMUGGLER)

func start_queue(needed_npc_amount : int)->void:
	remaining_customers = needed_npc_amount
	create_customer()


func continue_queue()->void:
	if remaining_customers >1:
		leave_customer()
		await get_tree().create_timer(1,false).timeout
		create_customer()
	else:
		leave_customer()
		#print("completed day!")
		game_manager.day_completed()


func create_customer()->void:
	
	current_customer = NPC_CUSTOMER.instantiate()
	var rand_text :String = ""
	var rand_npc : CustomerResource= npc_array[ randi_range(0, npc_array.size()-1)]
	var rand_dish = randi_range(0, available_dishes.size()-1 )
	var needed_dish
	var needed_text := rand_text
#	current_customer.character_sprite = npc_texture_array[rand_npc]
	
	
	#EventBus.give_item.emit(available_dishes[randi_range(0, available_dishes.size()-1 )])
	#game_manager.order_item(available_dishes[randi_range(0, available_dishes.size()-1 )])
	
	
	match rand_npc.corresponding_number_in_array:
		0: # disgruntled farmer
			
			if GlobalVar.fame ==0:
				var farmer_text_fame_0 = [
					"Gimme a mug of ale. Make it quick. I have to return to my fields.",
					"Nothin’ fancy. Just a mug of ale.",
					"Pour me an ale. Go on, what’re you standing there for?",
				]
				
				needed_text =farmer_text_fame_0[randi_range(0,farmer_text_fame_0.size()-1 ) ]
				needed_dish = ALE
			elif GlobalVar.fame >1:
				var farmer_text = [
					"You got another one of those strengthening ales?",
					"It’s a chilly day out. I hear you got a type of ale that can keep you warm from the inside.",
					"I’ve got an ache in my knees that won’t go away. Got a special kind of ale for that?",
					"Nothin’ fancy this time. Just a mug of ale."
				]
				var rand_order = randi_range(0,farmer_text.size()-1 )
				if rand_order == 3:
					needed_dish = ALE
				else:
					needed_dish = TANKARD_WITH_STRENGTH_ALE
				
				needed_text = farmer_text[rand_order]
			
			current_customer.character_sprite = npc_texture_array[0]
		1: # Frazzled Weaver
			
			if GlobalVar.fame ==0:
				
				var text_fame_0 = [
					"Weft five… weft five…. Oh, hello there! I’ll have a glass of gin.",
					"Oh, hello! Lovely day out, isn’t it? Perfect day for a beer. I don’t think I’ve been outside in… oh, well, let me see….",
					"I need a beer… Please, no questions. ",
				]
				var rand_order = randi_range(0,text_fame_0.size()-1 )
				needed_text =text_fame_0[rand_order]
				if rand_order ==0:
					
					needed_dish = GIN
				else:
					needed_dish = BEER
				
			elif GlobalVar.fame >1:
				var text = [
					"Hello there! My joints have started up their aching again. Could you make another one of those special gins?",
					"Oh, dear… I need to finish this bolt of fabric faster than I’ve got time for. It’s like my hands can’t weave quickly enough! Anyways, I’ll have an ale, and then it’s back to work…",
					"I’ve finally found a way to keep track of which thread I was on, so now I can take breaks from my weaving and stop by for a gin anytime! Oh, just a plain one today, dear.",
					
				]
				var rand_order = randi_range(0,text.size()-1 )
				needed_text = text[rand_order]
				if rand_order == 0:
					needed_dish = GLASS_WITH_STRENGTH_GIN
				elif rand_order == 1:
					needed_dish = TANKARD_WITH_SWIFTNESS_ALE
				else:
					needed_dish = GIN
			current_customer.character_sprite = npc_texture_array[1]
				
				
		2: # wandering drunkard
			
			
				
			var text_fame_0 = [
				"*hic* Gimme a beer.",
				"*hic* You gonna gimme a beer, or what? ",
				"Not enough coin for a beer. *hic* Fine, gimme an ale, then.",
			]
			var rand_order = randi_range(0,text_fame_0.size()-1 )
			needed_text =text_fame_0[rand_order]
			if rand_order ==0:
				
				needed_dish = GIN
			elif rand_order ==1:
				needed_dish = BEER
			else:
				needed_dish = ALE
			
			
			current_customer.character_sprite = npc_texture_array[2]
			
			
		3: # roguish smuggler
			
			
				
			var text_fame_0 = [
				"Quaint little place, this is. I almost don’t believe the rumors. Well, a glass of wine, then. ",
				"Oh? What a funny expression on your face. I’m not here to rob your little tavern. I doubt there’s anything here worth taking, anyways. 
				 Fix me a glass of galegrass wine, and I’ll be on my way.",
				"Another busy night, and our pockets are all the heavier for it, eh? Drinks on me, boys! 
				Eh - ah, well - just a round of ales for them, then. I myself will indulge in a hartroot wine. What? It’s not easy work that I do!",
			]
			var rand_order = randi_range(0,text_fame_0.size()-1 )
			needed_text =text_fame_0[rand_order]
			if rand_order ==0:
				needed_dish = WINE
			elif rand_order == 1 :
				needed_dish = WINEGLASS_WITH_SWIFTNESS_WINE
			elif rand_order == 2:
				needed_dish = WINEGLASS_WITH_STRENGTH_WINE
			
			
			current_customer.character_sprite = npc_texture_array[3]
			
			
			
			
			
		_:
			needed_dish  = available_dishes[rand_dish]
			needed_text = needed_dish.ingredient_name
			current_customer.character_sprite = npc_texture_array[rand_npc]
	
	
	current_customer.initialise()
	npc_animation.play("person_appear")
	#print("*customer walks in*")
	characters.add_child(current_customer)
	
	
	
	
	game_manager.on_item_order(needed_dish,needed_text)
	
	
	EventBus.order_item.emit(needed_dish)
	

func leave_customer() ->void:
	if current_customer !=null:
		npc_animation.play("person_disappear")
		#print("*customer walks away*")
		current_customer.queue_free()
	remaining_customers-=1
