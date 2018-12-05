-- World script

-- Performance bindings
local ipairs, print, next   =   ipairs, print, next
local error                 =   error
local tonumber              =   tonumber
local math, table           =   math, table

-- Requires
local Player                =   require("scripts.player")
local levelReader           =   require("util.levelreader")
local split                 =   require("util.split")
local l1                    =   require "maps"

print(l1.level)
print(l1.title)

World         = { g       = 10,
                  level   = "level1",
                }

function newWorld(screenSize)
    -------------------------------------------------------------------
    -------------------------------------------------------------------
    -------------------- WORLD INIT -----------------------------------
    -------------------------------------------------------------------
    -------------------------------------------------------------------
    local screenWidth = screenSize.x; local screenHeight = screenSize.y
    world = {g = 10,
             level = "level1",
             map   = {data = {},
                      tile_size = {20,20},
                      map_res = {800, 600}}
                  }

    -- Scaling
    world.scale = screenHeight/world.map.map_res[2]
    world.offset = math.floor((screenWidth - world.map.map_res[1]*world.scale)/2)
    
    -- Initialize player 1
    local x = math.min(100, 0.2*screenWidth)
    local y = math.max(500, 0.8*screenHeight)
    world.players = {Player.new(x, y)}
    
    -------------------------------------------------------------------
    ------------------  LOAD LEVEL  -----------------------------------
    -------------------------------------------------------------------
    function world:load()
        self.map.data = levelReader.loadLevel(self.level)
        if next(self.map.data) == nil then
            error("no map")
        end
        local temp = {}
        for i, line in ipairs(self.map.data) do
            temp[i] = {}
            s = split(line, ",")
            for j, char in ipairs(s) do
                temp[i][j] = tonumber(char)
            end
        end
        self.map.data = temp
    end
    
    -------------------------------------------------------------------
    ------------------  PRINT PLAYERS   -------------------------------
    -------------------------------------------------------------------    
    function world:print_players()
        for _, player in ipairs(self.players) do
            print(player.name)
        end
    end
    
    -------------------------------------------------------------------
    -----------------   UPDATE  ---------------------------------------
    -------------------------------------------------------------------
    function world:update(dt)
      for _, player in ipairs(self.players) do
        player:update(dt)
      end
    end
    
    --------------------------------------------------------------------
    ----------------    DRAW    ----------------------------------------
    --------------------------------------------------------------------
    function world:draw()
        local scale, offset     = world.scale, world.offset
        
        
        for i, rows in ipairs(self.map.data) do
            for j,col in ipairs(rows) do
                if col == 1 then
                    love.graphics.rectangle('fill',
                                            math.floor(20*scale)*(j-1)+offset,
                                            math.floor(20*scale)*(i-1),
                                            math.floor(20*scale),
                                            math.floor(20*scale))
                end
            end
        end
        
        
        for _, player in ipairs(self.players) do
            player:draw()
        end
        
    end
    
    return world
end

return {newWorld = newWorld}