# Placeholder art

Everything in this folder is temporary and expected to be replaced. Deleting it
breaks only `terrain_tileset.tres` and the `Ground` layer in `main.tscn`.

## Source

"Platformer - desert v1.0.0" tileset pack.

Fill in the author and source URL before shipping or publishing this repo, and
check the pack's own licence terms for whether attribution is required.

## Contents

- `tileset/terrain_atlas.png` - 320x80, a 20x5 grid of 16x16 tiles
- `tileset/terrain_tileset.tres` - a TileSet generated from that atlas
- `background/` - `sky`, `mountains` and `ruins` at 256x256, `sun` at 41x41
- `props/` - six 16x16 rocks, four trees. Nothing uses these yet.

The pack ships no character sprites, which is why the player is a placeholder
shape.

## Regenerating the TileSet

`terrain_tileset.tres` registers every non-transparent cell in the atlas and gives
a full-tile collision shape to the cells that are at least 95% opaque. To rebuild
it after swapping the art, select the `Ground` layer in `main.tscn`, open the
TileSet in the inspector, and use the atlas source's three-dots menu -> "Create
Tiles in Non-Transparent Texture Regions". Collision shapes are painted per tile
under the atlas's Physics Layer section.
