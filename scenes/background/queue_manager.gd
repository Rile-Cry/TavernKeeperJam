class_name QueueManager
extends Node

const NPC_CUSTOMER = preload("res://components/npc/npc_customer.tscn")
@onready var characters: Control = $"../Characters"
@onready var game_manager: GameManager = $"../GameManager"

var npc_texture_array : Array[Texture2D] = [
	preload("res://assets/character_sprites/crypticwanderer.PNG"),
	preload("res://assets/character_sprites/disgruntledfarmer.PNG"),
	preload("res://assets/character_sprites/frazzledweaver.PNG"),
	
]
@export var npc_amount : int = -1

@export var available_dishes : Array[TavernItem]

var remaining_customers : int
var current_customer : Customer
func start_queue()->void:
	remaining_customers = npc_amount
	create_customer()


func continue_queue()->void:
	if remaining_customers >1:
		leave_customer()
		create_customer()
	else:
		leave_customer()
		#print("completed day!")
		game_manager.day_completed()


func create_customer()->void:
	
	current_customer = NPC_CUSTOMER.instantiate()
	current_customer.character_sprite = npc_texture_array[randi_range(0, npc_texture_array.size()-1)]
	
	current_customer.initialise()
	print("*customer walks in*")
	characters.add_child(current_customer)
	#EventBus.give_item.emit(available_dishes[randi_range(0, available_dishes.size()-1 )])
	game_manager.order_item(available_dishes[randi_range(0, available_dishes.size()-1 )])
	
	

func leave_customer() ->void:
	if current_customer !=null:
		print("*customer walks away*")
		current_customer.queue_free()
	remaining_customers-=1
