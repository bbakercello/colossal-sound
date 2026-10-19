extends Node2D

const COLOSSUS_DIALOGUE: DialogueResource = preload("res://components/dialogue/colossus.dialogue")

@onready var _colossus: Colossus = %Colossus

var _inventory := Inventory.new()


func _ready() -> void:
	_add_rock(Vector2(220, 0))
	_colossus.interacted.connect(_on_dialogue_requested.bind(COLOSSUS_DIALOGUE))


func _add_rock(at: Vector2) -> void:
	var rock := Rock.new()
	rock.position = at
	rock.interacted.connect(_on_rock_picked_up.bind(rock))
	add_child(rock)


func _on_rock_picked_up(rock: Rock) -> void:
	_inventory.add("rock")
	rock.queue_free()


func _on_dialogue_requested(dialogue: DialogueResource) -> void:
	DialogueManager.show_dialogue_balloon(dialogue, "start", [_inventory])
