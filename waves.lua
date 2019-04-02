--- Module for spawning of waves of seals, fish, and glaciers
local Seal = require('seal')
local Fish = require('fish')
local Glacier = require('glacier')
local Waves = {}

-- Total "wave" area is 400

function Waves:new(world)
    o = {}
    setmetatable(o, self)
    self.__index = self

    o.world = world
    o.next_spawn = 2

    return o
end

function Waves:spawn_glacier(x, y, remove_callback)
    local glacier = Glacier:new(self.world)
    glacier.body:setX(x)
    glacier.body:setY(y)
    glacier:set_callback(remove_object)
    add_object(glacier)
    return glacier
end

function Waves:spawn_seal(x, y, remove_callback)
    local seal = Seal:new(self.world)
    seal.body:setX(x)
    seal.body:setY(y)
    seal:set_callback(remove_object)
    add_object(seal)
    return seal
end

function Waves:spawn_fish(x, y, remove_callback)
    local fish = Fish:new(self.world)
    fish.body:setX(x)
    fish.body:setY(y)
    add_object(fish)
    return fish
end

function Waves:set_callback(next_wave)
    self.next_wave = next_wave
end

--- Add the entities to the table
function Waves:spawn(objects, remove_callback)
    local width, height = love.graphics.getDimensions()
    r = math.random(0, 4)
    
    -- Hard code for now maybe change idk
    if r == 0 then
        local seal1 = self:spawn_seal(width, 150 + 96 / 2, remove_callback)
        local fish = self:spawn_fish(width, seal1.body:getY() + 104, remove_callback)
        local seal2 = self:spawn_seal(width, fish.body:getY() + 104, remove_callback)
    elseif r == 1 then
        local seal1 = self:spawn_seal(width, height - 50 - 96 / 2, remove_callback)
        local fish = self:spawn_fish(width, seal1.body:getY() - 104, remove_callback)
        local seal2 = self:spawn_seal(width, fish.body:getY() - 104, remove_callback)
    elseif r == 2 then
        local glacier = self:spawn_glacier(width, 150 - 40 + 96 / 2, remove_callback)
        local fish = self:spawn_fish(width, glacier.body:getY() + 104, remove_callback)
        local seal = self:spawn_seal(width, fish.body:getY() + 104, remove_callback)
    elseif r == 3 then
        local fish = self:spawn_fish(width, 150 / 2, remove_callback)
        local glacier = self:spawn_glacier(width, 150 - 40 + 96 / 2, remove_callback)
        local seal = self:spawn_seal(width, height - 50 - 96 / 2, remove_callback)
    elseif r == 4 then
        local fish = self:spawn_fish(width, height - 50 - 96 / 2, remove_callback)
        local seal = self:spawn_seal(width, fish.body:getY() - 96, remove_callback)
    end
end

function Waves:update(delta)
    self.next_spawn = self.next_spawn - delta
    if self.next_spawn <= 0 then
        if self.next_wave then self.next_wave() end
        self.next_spawn = 2
    end
end

return Waves