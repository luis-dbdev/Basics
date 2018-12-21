-- Main menu

-- Imports
local Buttons       =   require("util.buttons")


local pairs     =     pairs


-- Return table
local menu = {}

-- Use states interface
local mt = require("util.states")
setmetatable(menu, {__index = mt})

-- Locals
local screenSize        =   screenSize
local font = love.graphics.newFont("res/font/iomanoid.ttf",80)
local bg = {5, 56, 24}


-- Load the music statically for the menu
-- MUSIC TAKEN FROM DL SOUNDS
local music_path = "res/sound/music/Tribal Ritual.wav"
local music = love.audio.newSource(music_path, "static")
music:setLooping(true)



---------------------------------------------------------------
--------------- LOCAL FUNCS -----------------------------------
---------------------------------------------------------------
--          CHECK IF CLICK IS WITHIN BUTTON     --
local function click_check(button, x, y)
  if (x > button.x - button.width/2) and (x < button.x + button.width/2) then
    if (y > button.y - button.height/2) and (y < button.y + button.height/2) then
      return true
    end
  end
end





---------------------------------------------------------------
---------------------------------------------------------------
--------------- LOAD ------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
function menu:load()

  -------------------------------------
  --------- BUTTONS -------------------
  -------------------------------------
  local text_box = screenSize.x/3
  self.buttons      =
  {
  newGameButton   =   Buttons.new("NEW GAME", screenSize.x/2, 4*screenSize.y/10, screenSize.x/6, 3*font:getHeight()/4, text_box),
  loadGameButton  =   Buttons.new("LOAD GAME", screenSize.x/2, 5*screenSize.y/10, screenSize.x/6, 3*font:getHeight()/4, text_box),
  settingsButton  =   Buttons.new("SETTINGS", screenSize.x/2, 6*screenSize.y/10, screenSize.x/6, 3*font:getHeight()/4, text_box)
  }

  function self.buttons.newGameButton:click()
    print("NEW GAME!!!!!")
  end


end

---------------------------------------------------------------
---------------------------------------------------------------
--------------- UPDATE ----------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
function menu:update(dt)
  if not music:isPlaying() then
    music:play()
  end
  for _, button in pairs(self.buttons) do
    button:update(dt)
  end
end


---------------------------------------------------------------
---------------------------------------------------------------
--------------- DRAW ------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
-- Override draw
function menu:draw()
  -- Background
  love.graphics.setBackgroundColor(0.02, 0.22,0.094)
  
  -- Scaling
  local text_box = screenSize.x/3
  
  
  -- Title
  local default_font = love.graphics.getFont()
  love.graphics.setFont(font)
  love.graphics.printf("JAMBO MAMBO", screenSize.x/2-text_box/2, screenSize.y/10, text_box, "center")
  
  
  -- Draw start menu buttons
  for _, button in pairs(self.buttons) do
    button:draw()
  end
  
  
  love.graphics.setFont(default_font)
end


---------------------------------------------------------------
---------------------------------------------------------------
--------------- DRAW ------------------------------------------
---------------------------------------------------------------
---------------------------------------------------------------
-- Override mouserelease
function menu:mousereleased(x, y, button, istouch)
  if button == 1 then -- LMB... 2 is RMB, 3 is MMB
    for _, menu_button in pairs(self.buttons) do
      if click_check(menu_button, x, y) then
        menu_button:click()
        print("CLICKED")
      end
    end
  end
end

return menu