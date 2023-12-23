require "set_paths"
local lume = require("lume")
local love = require("love")

-- prove a luarocks lib works
x = 7.77
print(lume.round(x))

-- love .
function love.load()
end

function love.update(dt)
end

function love.draw()
    love.graphics.print("Hello World", 400, 300)
end
