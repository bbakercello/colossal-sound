# Architecture

The game is a left-to-right side-scroller. Right now it is a player that can walk
and jump on a strip of ground, and nothing else. This file records the structure
that exists and the few rules worth holding onto as it grows.

## Scene tree

```
main.tscn          Main (Node2D)          main.gd
├── Ground         TileMapLayer
└── Player         player.tscn            player/player.gd
```

`player.tscn` owns its collision shape, its placeholder visual and its camera. It
reads the input actions and moves itself. It holds no reference to `Main`, to the
ground, or to anything else outside itself, which is what makes it droppable into
any scene.

`main.gd` does one thing: hand the player the rectangle its camera may travel in.

```gdscript
func _ready() -> void:
	_player.set_camera_limits(camera_bounds)
```

That is small enough to look pointless, and it is the pattern worth keeping. The
player does not read the world's size, and the world does not reach into the
player's camera. The node that owns both passes what is needed between them.

## Rules to keep as this grows

- **Nothing reaches upward.** No `get_parent()`, no `../`, no `/root/...`. A scene
  takes what it needs through an `@export` or is handed it by whoever owns it.
- **Call down, signal up.** A parent may call methods on its children. A child
  reports outward by emitting a signal and lets its owner decide what that means.
- **`main.gd` is the only script allowed to know about two features at once.** It
  is the place where separate things get connected.
- **No autoloads.** They are globals, and they couple scenes to load order and to
  state they do not own. Use one only for something genuinely process-wide.
- **Pure data is a `Resource`, not a node and not a dictionary.** Give it a
  `class_name` and edit it as a `.tres` so writing content means editing a file in
  the inspector rather than a script.

## Physics layers

Named in the project settings so masks read as words rather than bit numbers:
layer 1 is `player`, layer 2 is `world`. The player sits on `player` and collides
only with `world`. Solid tiles carry their collision shapes in the TileSet itself,
not in separate bodies laid over the terrain.

## Presentation

A 640x360 viewport with `canvas_items` stretch and a 2x camera zoom, so the world
is drawn at 320x180 pixels while UI text still renders at a readable size. Texture
filtering is `Nearest` project-wide to keep the pixel art crisp.
