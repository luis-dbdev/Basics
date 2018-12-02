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
            
            -- Snap players
            if player.x - player.r < world.offset then
                player.x = world.offset + player.r
            elseif player.x + player.r > math.floor(self.map.map_res[1]*world.scale) + world.offset then
                player.x = math.floor(self.map.map_res[1]*world.scale) + world.offset - player.r
            end
            if player.y < 0 then
                player.y = 0
            end
            
            -- World collision
            local column = math.floor((player.x-world.offset)/(20*world.scale)) + 1
            local row = math.floor(player.y/(20*world.scale)) + 1
            local width = math.floor(2*player.r/(20*world.scale))
            
            if self.map.data[row][column] == 1 then
                local i,j = row, column
                local n = 1
                while true do
                    if self.map.data[i][j-n] == 0 then
                        print("left")
                        player.x = (j-n)*math.floor(20*world.scale) - player.r
                        break
                    elseif self.map.data[i][j+n] == 0 then
                        print("right")
                        player.x = (j+n)*math.floor(20*world.scale) + player.r
                        break
                    end
                    n = n + 1
                    if j + n > table.getn(self.map.data[1]) or j - n < table.getn(self.map.data[1]) then
                        player.x = world.offset
                        break
                    end
                end
            end
            
            local floor = screenHeight
            for i, rows in ipairs(self.map.data) do
                if rows[column] == 1 then
                    floor = (i-1)*math.floor(20*world.scale)
                    break
                elseif rows[column+width] == 1 then
                    floor = (i-1)*math.floor(20*world.scale)
                    break
                end
            end
            if player.y + player.r > floor then
                player.y = floor - player.r
            end
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