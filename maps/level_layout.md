# LEVEL FILES

## Layout
A level file (.txt) should comprise of the following sections:

- Header
- Data

### Header
The header has at least 4 pieces of information, spread out into 4 lines
in the following order:

- Map title
- Map size (in tiles)
- Tile size (in pixels)
- Map resolution (in pixels)

### Data
Immediately after the header, comes the data. The data is a comma-separated
string that when parsed will have the same dimensions as the map size. Each
value represents a tile, and the number represents which tile to be drawn,
where 0 represents no tile.