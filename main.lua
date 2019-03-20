local Penguin = require('penguin')
local Sprite = require('sprite')
local Seal = require('seal')

local objects = {}

-- Called Once
function love.load()
    love.window.setTitle('Penguin Game')
    love.graphics.setBackgroundColor(34.0/255, 49.0/255, 63.0/255)
    love.graphics.setNewFont(32)

    world = love.physics.newWorld(0, 0, true)

    local background = Sprite:new()
    background:set_image('background.png')
    table.insert(objects, background)

    local peng = Penguin:new(world)
    local width, height = love.graphics.getDimensions()
    peng.body:setX(128)
    peng.body:setY(100000000)
    table.insert(objects, peng)

    local seal = Seal:new(world)
    seal.body:setX(width)
    seal.body:setY(200)
    table.insert(objects, seal)

    world:setCallbacks(beginContact, endContact, preSolve, postSolve)
end

function beginContact(a, b, col)
    love.event.quit()
end

function endContact(a, b, col)
    print(a, b, col)
end
function preSolve(a, b, col)
    print(a, b, col)
end
function postSolve(a, b, col)
    print(a, b, col, ormalimpulse, tangentimpulse)
end

-- Called every time the system can
function love.update(delta)
    if love.keyboard.isDown('escape') then
        love.window.close()    
    end
    
    -- Update world
    world:update(delta)

    -- Call update on all objects
    for _, v in pairs(objects) do
        if v.update then v:update(delta) end
    end
end

-- Draw stuff
function love.draw()
    -- Call draw on all objects
    for _, v in pairs(objects) do
        v:draw()
    end
end