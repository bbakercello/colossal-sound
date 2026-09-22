class_name Player
extends CharacterBody2D

@export var speed: float = 110.0
@export var jump_velocity: float = -340.0
@export var ground_friction: float = 900.0

@onready var _visual: Node2D = %Visual
@onready var _camera: Camera2D = %Camera


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed(&"jump") and is_on_floor():
		velocity.y = jump_velocity

	var direction := Input.get_axis(&"move_left", &"move_right")
	if is_zero_approx(direction):
		velocity.x = move_toward(velocity.x, 0.0, ground_friction * delta)
	else:
		velocity.x = direction * speed
		_visual.scale.x = -1.0 if direction < 0.0 else 1.0

	move_and_slide()


func set_camera_limits(bounds: Rect2) -> void:
	_camera.limit_left = roundi(bounds.position.x)
	_camera.limit_top = roundi(bounds.position.y)
	_camera.limit_right = roundi(bounds.end.x)
	_camera.limit_bottom = roundi(bounds.end.y)
	_camera.reset_smoothing()
