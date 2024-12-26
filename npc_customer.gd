class_name Customer
extends Control
@onready var npc: TextureRect = $Npc

@export var character_sprite : Texture2D

func initialise()->void:
	await ready
	npc.texture = character_sprite
