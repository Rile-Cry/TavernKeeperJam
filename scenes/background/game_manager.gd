class_name GameManager
extends Control
@onready var label: Label = $Label
@onready var queue_manager: QueueManager = $"../QueueManager"
@onready var dialogue_box: TextureRect = $"../DialogueBox"
@onready var rich_text_label: RichTextLabel = $"../DialogueBox/RichTextLabel"

var queue_started :bool = false
var ordered_item: TavernItem
func _ready() -> void:
	EventBus.start_queue.connect(on_start_queue)
	EventBus.give_item.connect(on_item_given)
	

func on_start_queue()->void:
	if !queue_started:
		queue_started = true
		#print("queue started")
		queue_manager.start_queue()
		update_label()
	else:
		#print("queue already started")
		pass


func order_item(item: TavernItem)->void:
	#print("ordered item: " + str(item.ingredient_name))
	rich_text_label.text = "please bring me [color=red]"+ str(item.ingredient_name) + "[/color]"
	ordered_item = item
	update_label()
	pass

func on_item_given(item: TavernItem) ->void:
	
	if ordered_item.ingredient_name == item.ingredient_name:
		#print("items match so proceeding to next customer")
		queue_manager.continue_queue()
	#elif 


func day_completed()->void:
	update_label()
	#print("day completed")


func update_label() ->void:
	label.text = "Remaining customers: " + str(queue_manager.remaining_customers)
