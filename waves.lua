--- Module for spawning of waves of seals, fish, and glaciers
local Seal = require('seal')
local Fish = require('fish')
local Waves = {}

function Waves:new(world)
    o = {}
    setmetatable(o, self)
    self.__index = self

    o.world = world
    o.next_spawn = 2

    return o
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
    local width, _ = love.graphics.getDimensions()
    
    local seal1 = self:spawn_seal(width, 150 + 96/2, remove_callback)
    local fish = self:spawn_fish(width, seal1.body:getY() + 96, remove_callback)
    local seal2 = self:spawn_seal(width, fish.body:getY() + 96, remove_callback)
end

function Waves:update(delta)
    self.next_spawn = self.next_spawn - delta
    if self.next_spawn <= 0 then
        if self.next_wave then self.next_wave() end
        self.next_spawn = 2
    end
end

return Waves