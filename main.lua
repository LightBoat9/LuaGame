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

    local width, height = love.graphics.getDimensions()

    local seal = Seal:new(world)
    seal.body:setX(width)
    seal.body:setY(150 + 96/2)
    table.insert(objects, seal)

    local fish = Fish:new(world)
    fish.body:setX(width)
    fish.body:setY(seal.body:getY() + 96)
    table.insert(objects, fish)

    local seal2 = Seal:new(world)
    seal2.body:setX(width)
    seal2.body:setY(fish.body:getY() + 96)
    table.insert(objects, seal2)

    local peng = Penguin:new(world)
    peng.body:setX(128)
    peng.body:setY(height / 2)
    table.insert(objects, peng)

    world:setCallbacks(beginContact)
end

--- Called when two fixtures collide
function beginContact(fixture1, fixture2)
    -- Create a table with the fixture userdata as its key and the fixture as the value
    fixtures = { [fixture1:getUserData().name]=fixture1:getUserData(), [fixture2:getUserData().name]=fixture2:getUserData() }
    
    if fixtures.penguin then
        if fixtures.seal then    
            print('Penguin Hurt')
        elseif fixtures.fish then
            destroy(fixtures.fish)
            print('Yummy Fish')
        end
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

function destroy(object)
    for key, value in pairs(objects) do
        if value == object then
            table.remove(objects, key)
        end
    end
end