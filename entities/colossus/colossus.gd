class_name Colossus
extends Sprite2D

signal interacted

@export var reach := Vector2(635, 470)
@export var reach_size := Vector2(220, 90)


func _ready() -> void:
	var interactable := Interactable.new()
	interactable.position = reach
	interactable.size = reach_size
	interactable.interacted.connect(_on_interacted)
	add_child(interactable)



func _on_interacted() -> void:
	interacted.emit()
