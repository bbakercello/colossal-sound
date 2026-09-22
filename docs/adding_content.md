# Adding content

Recipes for the things you are most likely to do next, all of them done in the
editor.

## Tune movement

`Speed`, `Jump Velocity` and `Ground Friction` are exported on the player, so they
are editable in the inspector without touching the script. Gravity comes from
`get_gravity()`, which reads the project default, so changing it project-wide
changes it here.

At the current values the jump clears about 60 pixels, or just under four tiles.

## Replace the player's placeholder art

`player.tscn` already has an `AnimatedSprite2D` under `Visual`. Assign its
`SpriteFrames`, then delete the `Placeholder` and `Facing` polygons. `player.gd`
flips `Visual` rather than the sprite, so left-facing works with no extra code.

Keep the sprite and the collision shape anchored so the feet sit at the node's
origin, since positions in the world assume that.

## Paint terrain

Select `Ground` in `main.tscn` and use the TileMap panel. Tiles that were fully
opaque in the source atlas already carry a full-tile collision shape; anything
partly transparent was registered without collision, so decorative tiles will not
block the player. Add or edit shapes under the atlas's Physics Layer section.

If you widen the ground, widen `Camera Bounds` on `Main` to match, or the camera
will stop before the level does.

## Add a parallax background

Add a `Parallax2D` node with a `Sprite2D` child; there are sky, mountain and ruin
textures in `assets/placeholder/background/`. Set `scroll_scale.x` below 1 for
distance and leave `scroll_scale.y` at 1 so the horizon stays anchored to the
ground. To tile a layer, set `repeat_size.x` to the texture width and give the
sprite an `x` position of half that width so its left edge lands on zero.

## Add an input action

Project Settings -> Input Map. `move_left`, `move_right`, `jump` and `interact`
already exist, each bound to a key and a gamepad control; `interact` is unused so
far. Read continuous input with `Input.get_axis()` and discrete presses with
`event.is_action_pressed(&"name")` in `_unhandled_input()`.

## Add a new kind of thing

Give it its own folder next to `player/`, with its scene and script inside. Let it
do its own job and report outward with a signal rather than looking anything up:

```gdscript
# ❌ BAD - reaches out of its own scene
get_node("/root/Main/GUI/Panel").show_text(text)

# ✅ GOOD - reports, and lets Main decide
signal spoke(text: String)
```

Then connect it in `main.gd`, which is the one script allowed to know about two
features at once.

## Add levels

Once there is more than one screen's worth of world, move the ground and props out
of `main.tscn` into `levels/<name>/<name>.tscn` and have `main.tscn` instance it.
Give the level scene a script that exposes where the player starts and how far the
camera may travel, so `main.gd` can keep injecting those rather than the player
discovering them.
