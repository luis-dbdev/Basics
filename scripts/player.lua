-- Player.lua

-- Performance bindings
local tostring              =   tostring
local graphics              =   love.graphics
local keyboard              =   love.keyboard
local gamepad               =   love.joystick

-- Locals
local i                     =   1


function new(x, y)
    ---------------------------------------------------------
    ---------------------------------------------------------
    --------------  PLAYER INIT -----------------------------
    ---------------------------------------------------------
    ---------------------------------------------------------
    
    -- Give player definition and update player count
    player = {name = "player_" .. tostring(i),
              x    = x,
              y    = y,
              r    = 30,
              bbox = 20}
    i = i + 1
    
    ---------------------------------------------------------
    ------------    UPDATE  ---------------------------------
    ---------------------------------------------------------
    function player:update(dt)
        -- Move left or right
        if keyboard.isDown("left") then
            self.x = self.x - 10
        end
        if keyboard.isDown("right") then
            self.x = self.x + 10
        end
        --self.y = self.y + world.g
    end
    
    ---------------------------------------------------------
    ------------    DRAW    ---------------------------------
    ---------------------------------------------------------
    function player:draw()
        -- Placeholder circle object
        graphics.setColor(0, 0, 255) -- Set color to blue
        graphics.circle('fill', self.x, self.y, self.r) -- draw circle
        graphics.setColor(255, 255, 255) -- Reset color
    end
    
    return player
end

return {new = new}