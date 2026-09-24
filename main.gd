extends Node2D

@export var camera_bounds := Rect2(0, -360, 1600, 480)

@onready var _player: Player = %Player


func _ready() -> void:
	_player.set_camera_limits(camera_bounds)
	var bubble := TextBubble.new()
	_add_rock(Vector2(220, 0), "This rock has something to say.", bubble)
	_add_rock(Vector2(400, 0), "This rock is tired.", bubble)
	_add_rock(Vector2(580, 0), "This rock isn't even sure that it exists.", bubble)
	_add_rock(Vector2(760, 0), "This rock is just a pile of sand.", bubble)
	_add_rock(Vector2(940, 0), "This rock just wants to be left alone.", bubble)
	_add_tree(Vector2(260, 0), "This tree is tall and majestic.", bubble)
	_add_tree(Vector2(440, 0), "This tree is just a pile of leaves.", bubble)
	_add_tree(Vector2(620, 0), "This tree just wants to be left alone.", bubble)
	add_child(bubble)


func _add_rock(at: Vector2, message: String, bubble: TextBubble) -> void:
	var rock := Rock.new()
	rock.position = at
	rock.message = message
	rock.interacted.connect(bubble.show_message)
	rock.left.connect(bubble.close_if_showing)
	add_child(rock)

func _add_tree(at: Vector2, message: String, bubble: TextBubble) -> void:
	var tree := WorldTree.new()
	tree.position = at
	tree.message = message
	tree.interacted.connect(bubble.show_message)
	tree.left.connect(bubble.close_if_showing)
	add_child(tree)