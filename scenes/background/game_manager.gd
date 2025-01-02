class_name GameManager
extends Control
@onready var label: Label = $Label
@onready var queue_manager: QueueManager = $"../QueueManager"
@onready var time_transitions: AnimationPlayer = $"../TimeTransitions"

var queue_started :bool = false
var ordered_item: TavernItem
var customer_count : int = -1
func _ready() -> void:
	EventBus.start_queue.connect(on_start_queue)
	EventBus.give_item.connect(on_item_given)
	#EventBus.order_item.connect(on_item_order)
	

func on_start_queue(npc_amount : int)->void:
#	if !queue_started:
#		queue_started = true
		#print("queue started")
	queue_manager.start_queue(npc_amount)
	update_label()
	#time_transitions.play("to_day")
#	else:
		#print("queue already started")
#		pass


func on_item_order(item: TavernItem, text : Array[String])->void:
	#print("ordered item: " + str(item.ingredient_name))
	
	ordered_item = item
	Dialogic.VAR.CustomerName = text[0]
	Dialogic.VAR.CustomerString = text[1]
	Dialogic.start("customer")
	await Dialogic.timeline_ended
	GlobalGameEvents.tutorial_counter.emit()
	
	update_label()
	
	#await get_tree().create_timer(2).timeout
	#EventBus.move_pressed.emit()
	pass

func on_item_given(item: TavernItem) ->void:
	if ordered_item.ingredient_name == item.ingredient_name:
		#print("items match so proceeding to next customer")
		queue_manager.continue_queue()
	 


func day_completed()->void:
	EventBus.queue_completed.emit()
	update_label()
	#print("day completed")


func update_label() ->void:
	label.text = "Remaining customers: " + str(queue_manager.remaining_customers)
	customer_count+=1
	
	if customer_count == 0:
		time_transitions.play("to_day")
	if customer_count == 7:
		time_transitions.play("to_evening")
	
	if customer_count == 14:
		time_transitions.play("to_night")
