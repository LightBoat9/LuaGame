local Penguin = require('penguin')
local Sprite = require('sprite')

local objects = {}

-- Called Once
function love.load()
    love.window.setTitle('Penguin Game')
    love.graphics.setBackgroundColor(34.0/255, 49.0/255, 63.0/255)
    love.graphics.setNewFont(32)

    local background = Sprite:new()
    background:set_image('background.png')
    table.insert(objects, background)
    background:set_position(0, 0)

    local my_object = Penguin:new()
    local width, height = love.graphics.getDimensions()
    my_object:set_position(128, height / 2)
    table.insert(objects, my_object)
end


-- Called every time the system can
function love.update(delta)
    if love.keyboard.isDown('escape') then
        love.window.close()    
    end
    
    -- Call update on all objects
    for _, v in pairs(objects) do
        v:update(delta)
    end 
end

-- Draw stuff
function love.draw()
    -- Call draw on all objects
    for _, v in pairs(objects) do
        v:draw()
    end
end