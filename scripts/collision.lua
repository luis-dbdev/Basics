-- collision.lua

-- Performance bindings
local math                      =   math
local ipairs, pairs             =   ipairs, pairs

-- Locals


-- Return table
Collision                       =   {}

function Collision.map_collission(object,map)
    -- Calculate the boundaries of the box
    local bounds          =   {
                x1              =   object.x - object.bbox, -- left boundary
                x2              =   object.x + object.bbox, -- right boundary
                y1              =   object.y - object.bbox, -- upper boundary
                y2              =   object.y + object.bbox, -- lower boundary
    
    -- Tile size
    local tile_size       =   map.tile_size
    
    -- Translate object boundaries position to map coordinates
    local b_coord      =   {
                hz              =   {math.floor(bounds.x1/tile_size[1]),
                                     math.floor(bounds.x2/tile_size[1])},
                vt              =   {math.floor(bounds.y1/tile_size[2]),
                                     math.floor(bounds.y2/tile_size[2])}
                }
    
    -- Being a box, there are four points to check, check each to see if there's ground
    for x, i_coord in ipairs(b_coord.hz) do
        for y, j_coord in ipairs(b_coord.vt) do
            if map.data[i][j] > 0 then
                -- Collision
                -- Search function to find closest open space
                
            end
        end
    end
    
    
end

return Collision