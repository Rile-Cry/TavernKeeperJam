extends Node

var _tutorial := false


func _tutorial_check() -> void:
	if _tutorial and !GameGlobals.get_global_variable("tutorial"):
		if !Dialogic.VAR.TUTORIAL.FirstCustomer:
			Dialogic.VAR.TUTORIAL.FirstCustomer = true
		elif !Dialogic.VAR.TUTORIAL.SecondCustomer:
			Dialogic.VAR.TUTORIAL.SecondCustomer = true
		elif !Dialogic.VAR.TUTORIAL.ThirdCustomerArrives:
			Dialogic.VAR.TUTORIAL.ThirdCustomerArrives = true
		elif !Dialogic.VAR.TUTORIAL.ThirdCustomer:
			Dialogic.VAR.TUTORIAL.ThidCustomer = true
			_tutorial = false
			GameGlobals.set_global_variable("tutorial", true)
			GlobalGameEvents.tutorial_bar.disconnect(_on_move_to_bar)
			GlobalGameEvents.tutorial_bar.disconnect(_on_move_to_counter)
			GlobalGameEvents.tutorial_start.disconnect(_on_tutorial_start)
		
		Dialogic.start("tutorial")


func _ready() -> void:
	GlobalGameEvents.tutorial_bar.connect(_on_move_to_bar)
	GlobalGameEvents.tutorial_counter.connect(_on_move_to_counter)
	GlobalGameEvents.tutorial_start.connect(_on_tutorial_start)
	EventBus.submit_pressed.connect(_on_submit_item)
	
	if !GameGlobals.event_check["tutorial"]:
		Dialogic.start("tutorial")
		await GlobalGameEvents.queue_manager_ready
		EventBus.start_queue.emit(3)


func _on_move_to_bar() -> void:
	$MovePlayer.play("move_to_counter")

func _on_move_to_counter() -> void:
	$MovePlayer.play("move_to_bar")

func _on_tutorial_start() -> void:
	_tutorial = true

func _on_submit_item() -> void:
	_tutorial_check()
