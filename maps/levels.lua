-- Levels.lua

-- Requires
local levelReader           =   require("util.levelreader")
local split                 =   require("util.split")

-- Performance binds


-- Default
local Level                 = 
{ 
  level       =      "level1",
  scale       =      {1, 1}
}

Level.tiles                 = 
{
  {   
    id        =   1,
    type      =   ground,
    texFile   =   ""
  }
}

-- Load map data onto table    
function Level:load(level)
  -- If no level specified, use default
  self.level = level or self.level
  
  -- Read data from text file
  self.data = levelReader.loadLevel(self.level)
  
  -- If there is no map, give an error
  if next(self.data) == nil then
      error("no map")
  end
  
  -- Create temporary table to hold map data
  local temp = {}
  
  -- Parse through map data
  for i, line in ipairs(self.data) do
      if i == 1 then
          self.title = line
          
      elseif i == 2 then
        self.grid_size = {}
        s = split(line, ",")
        
        for i, num in ipairs(s) do
          self.grid_size[i] = tonumber(num)
        end
        
      elseif i == 3 then
        self.tile_size = {}
        s = split(line, ",")
        
        for i, num in ipairs(s) do
          self.tile_size[i] = tonumber(num)
        end
        
      elseif i == 4 then
        self.res = {}
        s = split(line, ",")
        
        for i, num in ipairs(s) do
          self.res[i] = tonumber(num)
        end
        
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


-------------------------------------------------------------------

-- Constructor
function new()
  newLevel                =   {}
  setmetatable(newLevel, {__index = Level})
  return newLevel
end

return {new = new}