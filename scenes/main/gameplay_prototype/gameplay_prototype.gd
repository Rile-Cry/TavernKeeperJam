extends Node

@export var tally_menu : PackedScene


func _tutorial_check() -> void:
	
	if !GameGlobals.event_check["tutorial"]:
		if !Dialogic.VAR.TUTORIAL.FirstCustomer:
			Dialogic.VAR.TUTORIAL.FirstCustomer = true
		elif !Dialogic.VAR.TUTORIAL.SecondCustomer:
			Dialogic.VAR.TUTORIAL.SecondCustomer = true
		elif !Dialogic.VAR.TUTORIAL.ThirdCustomer:
			Dialogic.VAR.TUTORIAL.ThirdCustomer = true
			GameGlobals.event_check["tutorial"] = true
		
		await GlobalGameEvents.customer_left
		Dialogic.start("tutorial")
		await Dialogic.timeline_ended
	
	GlobalGameEvents.tutorial_check.emit()


func _ready() -> void:
	GlobalGameEvents.tutorial_bar.connect(_on_move_to_bar)
	GlobalGameEvents.tutorial_counter.connect(_on_move_to_counter)
	EventBus.give_item.connect(_on_submit_item)
	EventBus.queue_completed.connect(_on_day_ended)
	
	if !GameGlobals.event_check["tutorial"]:
		Dialogic.start("tutorial")
		await Dialogic.timeline_ended
		MusicManager.play_music("gameplay")
		GlobalGameEvents.end_day()


func _on_move_to_bar() -> void:
	$MovePlayer.play("move_to_counter")

func _on_move_to_counter() -> void:
	$MovePlayer.play("move_to_bar")

func _on_submit_item(item: TavernItem) -> void:
	_tutorial_check()
	

func _on_day_ended() -> void:
	var tally := tally_menu.instantiate()
	add_child(tally)
