-- Tile collisions

-- Performance bindings
local floor, ceil     =     math.floor, math.ceil


local function getGridLimits(x, y, w, h, tile_size, anchor)
  --[[ Takes the position of an object, along with its width and height, 
  and converts its position to a set of grid limits to calculate collisions on.
  Assumes anchor sits in center of object. If the anchor sits somewhere else,
  it should be specified. A number between 1 and 4 can be used to select the
  anchor as a corner:
  
  1 ----------------------- 2
    |                     |
    |                     |
    |                     |
    |                     |
  4 ----------------------- 3
  
  --]]
  local offsets     =
  {
    { w/2,  w/2},
    {-w/2,  w/2},
    {-w/2, -w/2},
    { w/2, -w/2}
  }
  
  -- Standardize x,y position to always be at the center
  if anchor then
    x, y    =   x + offsets[anchor], y + offsets[anchor]
  end
  
  -- Find the top left and bottom right tiles that would be colliding with object, and return indeces
  grid_x1, grid_y1    =   floor( (x - w/2)/tile_size[1] ) + 1,  floor( (y - h/2)/tile_size[2] ) + 1
  grid_x2, grid_y2    =    ceil( (x + w/2)/tile_size[1] ),       ceil( (y + h/2)/tile_size[2] )
  
  return {grid_y1, grid_y2, grid_x1, grid_x2}
end

-- Check for collisions
local function collisionCheck(grid, level)
  for i = grid[1], grid[2] do
    for j = grid[3], grid[4] do
      
      if level.data[i][j] then
        -- COLLISION!!!
      end
      
    end
  end
end

---------------------------------------------------------------------------------------------------------

  
  
  
  
  
  
  