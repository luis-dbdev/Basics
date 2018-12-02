-- Level reader

-- Performance binding
local io                    =   io
local getWorkingDirectory   =   love.filesystem.getWorkingDirectory

-- see if the file exists
local function file_exists(file)
  local f = io.open(file, "rb")
  if f then f:close() end
  return f ~= nil
end

-- get all lines from a file, returns an empty 
-- list/table if the file does not exist
function loadLevel(level)
    cwd  = getWorkingDirectory()
    file = cwd .. "/maps/" .. level .. ".txt"
    if not file_exists(file) then return {} end
    lines = {}
    for line in io.lines(file) do 
    lines[#lines + 1] = line
    end
    return lines
end

return {loadLevel = loadLevel}