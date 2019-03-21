local Penguin = require('penguin')
local Sprite = require('sprite')
local Seal = require('seal')
local Fish = require('fish')

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
    peng.body:setY(height / 2)
    table.insert(objects, peng)

    local seal = Seal:new(world)
    print(seal.body)
    seal.body:setX(width)
    seal.body:setY(108 + 128/2)
    table.insert(objects, seal)

    local fish = Fish:new(world)
    fish.body:setX(width)
    fish.body:setY(seal.body:getY() + 128)
    table.insert(objects, fish)

    local seal2 = Seal:new(world)
    seal2.body:setX(width)
    seal2.body:setY(fish.body:getX() + 128)
    --table.insert(objects, seal2)

    print(seal.body)
    print(seal2.body)

    world:setCallbacks(beginContact)
end

--- Called when two fixtures collide
function beginContact(fixture1, fixture2)
    -- Create a table with the fixture userdata as its key and the fixture as the value
    fixtures = { [fixture1:getUserData()]=fixture1, [fixture2:getUserData()]=fixture2 }
    
    if fixtures.penguin and fixtures.seal then    
        print('Penguin Hurt')
    end

    return true -- No actual collisions
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