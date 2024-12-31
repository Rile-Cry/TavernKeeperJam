extends Node

signal queue_manager_ready

signal tutorial_bar
signal tutorial_counter
signal tutorial_start

#region Narrative
#signal dialogues_requested(dialogue_blocks: Array[DialogueDisplayer.DialogueBlock])
#signal dialogue_display_started(dialogue: DialogueDisplayer.DialogueBlock)
#signal dialogue_display_finished(dialogue: DialogueDisplayer.DialogueBlock)
#signal dialogue_blocks_started_to_display(dialogue_blocks: Array[DialogueDisplayer.DialogueBlock])
#signal dialogue_blocks_finished_to_display()
#endregion

func _ready() -> void:
	Dialogic.signal_event.connect(_on_dialogic_signal_called)


func _on_dialogic_signal_called(arg) -> void:
	match arg:
		"move_to_bar":
			tutorial_bar.emit()
		"move_to_counter":
			tutorial_counter.emit()
		"tutorial_start":
			tutorial_start.emit()
