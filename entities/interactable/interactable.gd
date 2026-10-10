class_name Interactable
extends Area2D

signal interacted

var _player_inside := false


func _ready() -> void:
	var shape := RectangleShape2D.new()
	shape.size = Vector2(40, 40)
	var collision := CollisionShape2D.new()
	collision.shape = shape
	collision.position = Vector2(0, -20)
	add_child(collision)

	collision_layer = 0
	collision_mask = 1
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)


func _unhandled_input(event: InputEvent) -> void:
	if not event.is_action_pressed(&"interact"):
		return
	if not _player_is_inside():
		return
	interacted.emit()
	get_viewport().set_input_as_handled()


func _player_is_inside() -> bool:
	for body in get_overlapping_bodies():
		if body is Player:
			return true
	return _player_inside


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		_player_inside = true


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		_player_inside = false
