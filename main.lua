local Penguin = require('penguin')

local objects = {
}

-- Called Once
function love.load()
    love.graphics.setBackgroundColor(34.0/255, 49.0/255, 63.0/255)
    love.graphics.setNewFont(32)
    print()

    my_object = Penguin:new()
    my_object:set_scale(2, 2)
    center_x, center_y = love.graphics.getDimensions()
    my_object:set_position(20, 20)
    table.insert(objects, my_object)

end


-- Called every time the system can
function love.update(delta)
    local v_input = (love.keyboard.isDown('down') and 1 or 0) - (love.keyboard.isDown('up') and 1 or 0)
    my_object:move(0, 100 * delta * v_input)

    if love.keyboard.isDown('escape') then
        love.window.close()    
    end
end

-- Draw stuff
function love.draw()
    love.graphics.print("Penguin Game", 10, 10)
    -- Call draw on all objects
    for _, v in pairs(objects) do
        v:draw()
    end 
end