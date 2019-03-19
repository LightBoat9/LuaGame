local Sprite = require('sprite')
local Seal = {}

Seal.sprite = Sprite:new()
Seal.sprite:set_image('seal.png')
Seal.sprite:set_centered(true)

function Seal:new(world, x, y)
    o = {}
    setmetatable(o, self)
    self.__index = self
    self.body = love.physics.newBody(world, x, y)
    return o
end

function Seal:update(delta)
    self.body:applyForce(-100 * delta, 0)
    if self.body:getX() <= 0 then
        width, _ = love.graphics.getDimensions()
        self.position.x = width
    end
end

function Seal:draw()
    self.sprite:draw()
end

function Seal:set_position(x, y)
    KBody.set_position(self, x, y)
    self.sprite:set_position(x, y)
end

return Seal