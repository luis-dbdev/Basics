-- Main.lua

-- Globals
screenSize                    = {x = 0, y = 0, ratio = 1}

-- Performance bindings
local love                          = love
local table, math                   = table, math
local pairs, ipairs, next, print    = pairs, ipairs, next, print

-- Requires
local World                         = require("scripts.world")
local Debugger                      = require("util.debugger")
local main_menu                     = require("scripts.main_menu")

-- Locals
local joysticks                     = {}
local point                         = {}
local debugging                     = true
local state                         = 1
local state_table                   = {main_menu}

-- Love load function
function love.load()
  -- Set display and get window sizesF
  love.window.setMode(0, 0, {fullscreen = true})
  love.graphics.setDefaultFilter('nearest', 'nearest', 0)
  screenSize.x        =   love.graphics.getWidth()
  screenSize.y        =   love.graphics.getHeight()
  screenSize.ratio    =   screenSize.x / screenSize.y
  
  -- Initialize joysticks
  joysticks           =   love.joystick.getJoysticks()
  
  
  
  -- Make world
  --world               =   World.new(screenSize)
  main_menu:load()
  
end


-- Love update callback
function love.update(dt)
  --world:update(dt)
  state_table[state]:update(dt)
end

--------------------------------------------------------
--------------------------------------------------------
---------- MOUSE CALLBACKS ---------------------------
--------------------------------------------------------
--------------------------------------------------------
function love.mousepressed(x, y, button, istouch, presses)
  state_table[state]:mousepressed(x, y, button, istouch, presses)
end

function love.mousereleased(x, y, button, istouch)
  state_table[state]:mousereleased(x, y, button, istouch, presses)
end

--------------------------------------------------------
--------------------------------------------------------
---------- KEYBOARD CALLBACKS ---------------------------
--------------------------------------------------------
--------------------------------------------------------
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
  if debugging then
    Debugger:draw()
  end
  
  main_menu:draw()
    
  -- Draw world
  --world:draw()
    
end