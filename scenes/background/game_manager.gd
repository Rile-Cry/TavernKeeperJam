class_name GameManager
extends Control
@onready var label: Label = $Label
@onready var queue_manager: QueueManager = $"../QueueManager"
@onready var dialogue_box: TextureRect = $"../DialogueBox"
@onready var rich_text_label: RichTextLabel = $"../DialogueBox/RichTextLabel"
@onready var dialogue_animation: AnimationPlayer = $"../DialogueAnimation"

var queue_started :bool = false
var ordered_item: TavernItem
func _ready() -> void:
	EventBus.start_queue.connect(on_start_queue)
	EventBus.give_item.connect(on_item_given)
	EventBus.order_item.connect(on_item_order)
	

func on_start_queue(npc_amount: int)->void:
	if !queue_started:
		queue_started = true
		#print("queue started")
		queue_manager.start_queue(npc_amount)
		update_label()
	else:
		#print("queue already started")
		pass


func on_item_order(item: TavernItem)->void:
	#print("ordered item: " + str(item.ingredient_name))
	dialogue_animation.play("dialogue_appear")
	rich_text_label.text = "please bring me [color=red]"+ str(item.ingredient_name) + "[/color]"
	ordered_item = item
	
	update_label()
	pass

func on_item_given(item: TavernItem) ->void:
	dialogue_animation.play("dialogue_disappear")
	if ordered_item.ingredient_name == item.ingredient_name:
		#print("items match so proceeding to next customer")
		queue_manager.continue_queue()
	 


func day_completed()->void:
	update_label()
	#print("day completed")


func update_label() ->void:
	label.text = "Remaining customers: " + str(queue_manager.remaining_customers)
