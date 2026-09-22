# Conventions

These follow Godot's own style guide and project organization docs. Where the
engine has an opinion, we use it rather than inventing something.

## Files and folders

Group by feature, not by file type, so a feature can be deleted or moved in one
piece:

```
main.tscn / main.gd          entry point
player/                      player scene and script
assets/placeholder/          disposable art
docs/                        this folder
```

As features arrive they get their own folder next to `player/`, each holding its
scene, its script, and any resources only it uses.

- `snake_case` for every file and folder, including imported art. Rename assets on
  import rather than living with `00Atlas.png`.
- A scene and its script share a name: `player.tscn` / `player.gd`.
- Resources a single feature owns live beside it, not in a global `resources/`
  folder.

## Node names

`PascalCase`, describing the role rather than the type: `Ground`, `Visual`,
`Camera`. Do not name a node `Sprite2D2`.

## GDScript

Tabs for indentation, two blank lines between functions, one between a class's
member block and its first function.

Order members as the style guide specifies:

```gdscript
@tool
## Doc comment, if the class needs one.
class_name Player
extends CharacterBody2D

signal died

const MAX_FALL_SPEED := 600.0

@export var speed: float = 110.0

var _coyote_time := 0.0

@onready var _visual: Node2D = %Visual


func _ready() -> void:
	pass
```

- Static types everywhere: `var speed: float = 110.0`, `func f(x: int) -> void:`.
  Use `:=` when the type is obvious from the right-hand side.
- `snake_case` for variables and functions, `PascalCase` for classes,
  `CONSTANT_CASE` for constants.
- Prefix private members with `_`. Members another scene is meant to touch stay
  unprefixed, which makes the intended API obvious at a glance. In `player.gd`,
  `set_camera_limits()` is public and `_visual` is not, on purpose.
- Use `&"name"` for action names and other `StringName` arguments to skip a
  per-call string allocation.
- Comments are the exception, not the rule. At most one `##` doc comment per class
  to say what it is responsible for; beyond that, prefer a clearer name over a
  comment.

## Node references

Use scene-unique names (`%Visual`) rather than paths. A path like
`$Visual/Sprite2D` breaks the moment the tree is rearranged; a unique name
survives it. Never use `get_parent()` or `../` to reach upward -- take what you
need through an `@export` or have the parent hand it to you.

## Signals versus calls

Call downwards, signal upwards. A parent may call a method on a child it owns. A
child that needs to tell the outside world something emits a signal and lets
whoever owns it decide what that means. Name signals for what happened (`died`,
`closed`), not for what should happen next (`play_death_animation`).

## Autoloads

There are none, and new ones need a real justification. An autoload is a global,
and globals make scenes depend on load order and on state they do not own. Reach
for one only for something genuinely process-wide, such as a save-game service or
a scene transition manager, and never as a convenient place to stash references
between scenes.

## Resources versus nodes

If a thing is only data -- no transform, no children, no per-frame work -- make it
a `Resource` with a `class_name` and edit it as a `.tres`. Dialogue, item
definitions and tuning tables belong there. Nodes are for things that exist in the
tree.

## Editor-time validation

A scene with an exported property that must be filled in should implement
`_get_configuration_warnings()` under `@tool`, so a missing assignment shows as a
warning in the scene tree instead of failing at runtime.

## Physics and input

Physics and movement go in `_physics_process()`; anything frame-rate dependent
goes in `_process()`. Read continuous movement by polling `Input.get_axis()`, and
handle discrete presses that UI might want to swallow in `_unhandled_input()` so
`set_input_as_handled()` works.

Never hardcode keycodes. Add an action in the project's input map and reference it
by name.
