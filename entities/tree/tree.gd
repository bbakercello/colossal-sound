class_name WorldTree
extends Node2D

signal interacted


func _ready() -> void:
	var sprite := Sprite2D.new()
	var index := randi_range(1, 4)
	sprite.texture = load("res://assets/placeholder/props/tree_%d.png" % index)
	sprite.position = Vector2(0, -sprite.texture.get_height() / 2.0)
	add_child(sprite)

	var interactable := Interactable.new()
	interactable.interacted.connect(_on_interacted)
	add_child(interactable)


func _on_interacted() -> void:
	interacted.emit()
