extends Node2D

const ROCK_DIALOGUE: DialogueResource = preload("res://components/dialogue/rock.dialogue")


func _ready() -> void:
	_add_rock(Vector2(220, 0), ROCK_DIALOGUE)


func _add_rock(at: Vector2, dialogue: DialogueResource) -> void:
	var rock := Rock.new()
	rock.position = at
	rock.interacted.connect(_on_dialogue_requested.bind(dialogue))
	add_child(rock)


func _on_dialogue_requested(dialogue: DialogueResource) -> void:
	DialogueManager.show_dialogue_balloon(dialogue, "start")
