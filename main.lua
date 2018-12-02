-- Main.lua

-- Performance bindings
local love                          = love
local table, math                   = table, math
local pairs, ipairs, next, print    = pairs, ipairs, next, print

-- Requires
local World                         = require("scripts.world")

-- Locals
local screenSize                    = {x = 0, y = 0, ratio = 1}
local joysticks                     = {}
local point = {}

-- Love load function
function love.load()
    -- Set display and get window sizes
    love.window.setMode(0, 0, {fullscreen = true})
    love.graphics.setDefaultFilter('nearest', 'nearest', 0)
    screenSize.x        =   love.graphics.getWidth()
    screenSize.y        =   love.graphics.getHeight()
    screenSize.ratio    =   screenSize.x / screenSize.y
    
    -- Initialize joysticks
    joysticks           =   love.joystick.getJoysticks()
    
    -- Make world
    world               =   World.newWorld(screenSize)
    world:load()
    
end


-- Love update callback
function love.update(dt)
    world:update(dt)
    
end

-- Love keypress callback
function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
    
    --world.keypressed(key)
end

-- Love keyrelease callback
function love.keyreleased(key)
    --world.keyrelease(key)
end

--------------------------------------------------------
--------------------------------------------------------
---------- GAMEPAD CALLBACKS ---------------------------
--------------------------------------------------------
--------------------------------------------------------
-- Love gamepad press callback
function love.gamepadpressed(joystick, button)
    -- world.gamepadpressed(joystick, button)
end

-- Love gamepad release callback
function love.gamepadreleased(joystick, button)
    -- world.gamepadreleased(joystick, button)
end

-- Love gamepad connected
function love.joystickadded(joystick)

end

-- Love gamepad removed
function love.joystickremoved(joystick)

end


------------------------------------------------------------------
------------------  TOUCHSCREEN ----------------------------------
------------------------------------------------------------------
--[[
function love.touchpressed(id, x, y, dx, dy, pressure)
end

function love.touchmoved(id, x, y, dx, dy, pressure)
end
--]]
------------------------------------------------------------------
------------------  DRAW    --------------------------------------
------------------------------------------------------------------
function love.draw()
    -- Make a debugging panel
    love.graphics.setColor(60, 60, 60, 0.3) -- Translucent grey
    love.graphics.rectangle('fill', 80, 80, 600, 200)
    
    -- Debugging strings
    love.graphics.setColor(255, 255, 0)
    love.graphics.print("Screen width: " .. screenSize.x .. "   Screen height: " .. screenSize.y
        .. "\nRatio: " .. screenSize.ratio
        .. "\nFPS: " .. tostring(love.timer.getFPS( ))
        .. "\nTouch-x: " .. tostring(point.x) .. "\tTouch-y: " .. tostring(point.y)
        .. "\tTouch-p: " .. tostring(point.pressure),
        100, 100)
    love.graphics.setColor(255, 255, 255)
    
    -- Draw world
    world:draw()
    
end