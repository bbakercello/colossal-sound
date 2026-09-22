# colossal-sound

A 2D side-scroller in Godot 4.7, at the skeleton stage: a player that walks and
jumps on a strip of ground, and the conventions to grow it from.

## Running it

Open the folder in Godot 4.7 and press F5. `main.tscn` is the main scene.

| Action | Keyboard | Gamepad |
| --- | --- | --- |
| Walk | `A` / `D` or arrow keys | left stick |
| Jump | `Space` | bottom button |
| Interact | `E` | west button (unused so far) |

## Layout

```
main.tscn / main.gd      Main, the ground, and the player instance
player/                  player scene, movement, camera
assets/placeholder/      disposable art plus the generated TileSet
docs/                    architecture, conventions, recipes
```

## Docs

- [docs/architecture.md](docs/architecture.md) - what exists, and the handful of
  rules worth keeping as it grows.
- [docs/conventions.md](docs/conventions.md) - naming, GDScript style, and the
  reasoning behind them.
- [docs/adding_content.md](docs/adding_content.md) - recipes for art, terrain,
  background layers, input actions, and new features.

The same rules are enforced for AI assistance through `.cursor/rules/`.

## State of the art

Everything under `assets/placeholder/` is temporary and the player is a coloured
rectangle. `player.tscn` has an empty `AnimatedSprite2D` under its `Visual` node,
so real art is a matter of assigning `SpriteFrames` and deleting the placeholder
polygons. See [assets/placeholder/credits.md](assets/placeholder/credits.md) for
where the art came from and what still needs attribution.
