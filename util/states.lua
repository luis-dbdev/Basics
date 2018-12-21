-- State interface

local mt = {}

function mt:update(dt) end

function mt:draw() end

function mt:mousepressed(x, y, button, istouch, presses) end

function mt:mousereleased(x, y, button, istouch) end

function mt:keypressed(key) end

function mt:keyreleased(key) end

function mt:gamepadpressed(joystick, button) end

function mt:gamepadreleased(joystick, button) end

return mt