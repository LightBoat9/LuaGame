local Penguin = require('penguin')
local Sprite = require('sprite')
local Waves = require('waves')

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
    
    local peng = Penguin:new(world)
    peng.body:setX(128)
    peng.body:setY(height / 2)
    add_object(peng)
    
    world:setCallbacks(beginContact)

    waves = Waves:new(world)
    waves:set_callback(next_wave)
    add_object(waves)
end

function next_wave()
    waves:spawn(objects, remove_object)
end

function add_object(o)
    table.insert(objects, o)
end

function remove_object(o)
    -- Loop through objects and find the object
    -- if found remove it from the table
    for key, value in pairs(objects) do
        if value == o then
            table.remove(objects, key)
        end
    end
end

--- Called when two fixtures collide
function beginContact(fixture1, fixture2)
    -- Create a table with the fixture userdata as its key and the fixture as the value
    fixtures = { [fixture1:getUserData().name]=fixture1:getUserData(), [fixture2:getUserData().name]=fixture2:getUserData() }
    
    if fixtures.penguin then
        if fixtures.seal or fixtures.glacier then    
            print('Penguin Hurt')
        elseif fixtures.fish then
            remove_object(fixtures.fish)
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
        if v.draw then v:draw() end
    end
end