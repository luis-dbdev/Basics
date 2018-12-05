-- Levels.lua

local levelReader           =   require("util.levelreader")
local split                 =   require("util.split")

function new(level)
    -- Constructor
    Level = {level = level}
    
    -- Load map data onto table    
    function Level:load(level)
        -- If no level specified, use the one given in constructor
        level = level or self.level
        
        -- Read data from text file
        self.data = levelReader.loadLevel(level)
        
        -- If there is no map, give an error
        if next(self.data) == nil then
            error("no map")
        end
        
        -- Parse through the csv, turn strings into ints
        --[[ TODO:
            Must include a header in the file that specifies:
            Map size, tile size, map resolution,
            and collidable objects (ground and platforms).
            The collidable objects must be grouped into two
            different tables, those active and those inactive.
            All ground and platform should start as inactive.
            These must ONLY become active (for collision detection)
            once they're drawn to the screen.
        --]]
        local temp = {}
        
        for i, line in ipairs(self.data) do
            if i == 1 then
                self.title = line
            elseif i == 2 then
                self.grid_size = split(line, ",")
            elseif i == 3 then
                self.tile_size = split(line, ",")
            elseif i == 4 then
                self.res = split(line, ",")
            else
                temp[i-4] = {}
                s = split(line, ",")
                
                for j, char in ipairs(s) do
                    temp[i-4][j] = tonumber(char)
                end
            end
        end
        
        -- Allocate the parsed data table to the level table
        self.data = temp
    end

    return Level
end

return {new = new}