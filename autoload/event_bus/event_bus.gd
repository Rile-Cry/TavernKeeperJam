extends Node


# game handling signals for customers
signal start_queue(npc_amount: int)
signal give_item(item: TavernItem)
signal submit_pressed
signal order_item(item: TavernItem)
