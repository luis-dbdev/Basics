-- Buttons

-- Performance binds
local unpack          =   unpack

-- Metatable
local Button          =
{
  height      =   100, -- Default height of the button (based on screenSize)
  width       =   300, -- Default width of the button
  status      =   "normal", -- Default status
  x           =   100,    -- Default position
  y           =   100,
  box         =   500,
  text        =   "BUTTON"  -- Default text
}

local font_status = 
{
  disabled  =   {076/255, 078/255, 081/255},
  hover     =   {188/255, 018/255, 018/255},
  normal    =   {255/255, 255/255, 255/255}
}

function Button:draw()
  -- BUTTON WILL ALWAYS BE CENTERED
  local font    =   love.graphics.getFont()
  local h       =   font:getHeight()
  
  love.graphics.setColor(unpack(font_status[self.status]))
  love.graphics.printf(self.text, self.x-self.box/2, self.y-h/2, self.box, "center")
  love.graphics.setColor(255, 255, 255, 1)
end

function Button:update(dt)
  self.status = "normal"
  local mousex, mousey  =   love.mouse.getPosition()
  if (mousex > self.x - self.width/2) and (mousex < self.x + self.width/2) then
    if (mousey > self.y - self.height/2) and (mousey < self.y + self.height/2) then
      self.status   =   "hover"
    end
  end
end

function Button:click()
  -- Button click callback function
end


-- Constructor
function new(text, x, y, width, height, box)
  newButton                =   {height = height, width = width, x = x, y = y, text = text, box = box}
  setmetatable(newButton, {__index = Button})
  return newButton
end

return {new = new}