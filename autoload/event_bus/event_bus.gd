extends Node


# game handling signals for customers
signal start_queue(npc_amount : int)
signal give_item(item: TavernItem)
signal order_item(item: TavernItem)

#scene movement
signal submit_pressed
signal move_pressed

#
signal queue_completed
