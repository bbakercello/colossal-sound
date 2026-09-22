extends Node2D

@export var camera_bounds := Rect2(0, -360, 1600, 480)

@onready var _player: Player = %Player


func _ready() -> void:
	_player.set_camera_limits(camera_bounds)
