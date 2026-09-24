class_name WorldTree
extends Node2D

signal interacted(message: String)
signal left(message: String)

@export var message: String = "This tree is tall and majestic."


func _ready() -> void:
	var sprite := Sprite2D.new()
	var index := randi_range(1, 4)
	sprite.texture = load("res://assets/placeholder/props/tree_%d.png" % index)
	sprite.position = Vector2(0, -sprite.texture.get_height() / 2.0)
	add_child(sprite)

	var interactable := Interactable.new()
	interactable.message = message
	interactable.interacted.connect(_on_interacted)
	interactable.left.connect(_on_left)
	add_child(interactable)


func _on_interacted(text: String) -> void:
	interacted.emit(text)


func _on_left(text: String) -> void:
	left.emit(text)
