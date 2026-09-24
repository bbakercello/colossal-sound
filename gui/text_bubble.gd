class_name TextBubble
extends CanvasLayer

var _panel: ColorRect
var _label: Label


func _ready() -> void:
	layer = 10

	_panel = ColorRect.new()
	_panel.position = Vector2(24, 24)
	_panel.size = Vector2(592, 56)
	_panel.color = Color(0.08, 0.07, 0.11, 0.94)
	add_child(_panel)

	_label = Label.new()
	_label.position = Vector2(36, 40)
	_label.custom_minimum_size = Vector2(560, 28)
	_label.size = Vector2(560, 28)
	_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	_label.add_theme_font_size_override("font_size", 16)
	_label.add_theme_color_override("font_color", Color(0.96, 0.92, 0.84))
	add_child(_label)
	_set_open(false)


func _unhandled_input(event: InputEvent) -> void:
	if not _label.visible:
		return
	if event.is_action_pressed(&"interact"):
		_set_open(false)
		get_viewport().set_input_as_handled()


func show_message(text: String) -> void:
	_label.text = text
	_set_open(true)


func _set_open(open: bool) -> void:
	_panel.visible = open
	_label.visible = open

func close_if_showing(message: String) -> void:
	if _label.visible and _label.text == message:
		_set_open(false)
