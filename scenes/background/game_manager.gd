class_name GameManager
extends Control
@onready var label: Label = $Label
@onready var queue_manager: QueueManager = $"../QueueManager"

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
	print("ordered item: " + str(item.ingredient_name))
	ordered_item = item
	update_label()
	pass

func on_item_given(item: TavernItem) ->void:
	print("item received " + str(item.ingredient_name))
	if ordered_item.ingredient_name == item.ingredient_name:
		print("items match so proceeding to next customer")
		queue_manager.continue_queue()
		


func day_completed()->void:
	update_label()
	print("day completed")


func update_label() ->void:
	label.text = "Remaining customers: " + str(queue_manager.remaining_customers)
