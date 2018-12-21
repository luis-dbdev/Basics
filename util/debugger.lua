-- Make a debugging panel

-- Performance binds
local graphics            =   love.graphics
local unpack              =   unpack
local tostring            =   tostring

-- Locals
local screenSize          =   screenSize
local function reset_color() graphics.setColor(255, 255, 255, 1) end

-- Return table
local Debugger = 
{
  posx = 80,
  posy = 80,
  w = 600,
  h = 200,
  txt_col = {255, 255, 0, 1},
  lineheight = 14,
  line = nil
}

function Debugger:draw()
  -- Create surrounding rect
  graphics.setColor(60, 60, 60, 0.3) -- Translucent grey
  graphics.rectangle('fill', self.posx, self.posy, self.w, self.h)
  
  -- Debugging strings
  graphics.setColor(unpack(self.txt_col)) -- Change color
  -- Print screen config, FPS
  graphics.print("Screen width: " .. screenSize.x .. "   Screen height: " .. screenSize.y
      .. "\nRatio: " .. screenSize.ratio
      .. "\nFPS: " .. tostring(love.timer.getFPS( )),
      100, 100)
  self.line = self.lineheight*3 + self.posy + 20
  reset_color() -- Reset the color to white
end

function Debugger:print(string)
  graphics.setColor(unpack(self.txt_col))
  graphics.print(string, self.posx + 20, self.line)
  reset_color()
end


return Debugger