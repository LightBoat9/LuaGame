local Sprite = require('sprite')
local Seal = {}

Seal.sprite = Sprite:new()
Seal.sprite:set_image('seal.png')
Seal.sprite:set_centered(true)

function Seal:new(world, x, y)
    o = {}
    setmetatable(o, self)
    self.__index = self
    self.body = love.physics.newBody(world, x, y, 'dynamic')
    self.shape = love.physics.newCircleShape(64)
    self.fixture = love.physics.newFixture(self.body, self.shape)
    self.fixture:setUserData('Seal')
    return o
end

function Seal:update(delta)
    self.body:setLinearVelocity(-250, 0)
    if self.body:getX() <= 0 then
        width, _ = love.graphics.getDimensions()
        self.body:setX(width)
    end
end

function Seal:draw()
    self.sprite:draw(self.body:getX(), self.body:getY())
    love.graphics.circle('line', self.body:getX(), self.body:getY(), self.shape:getRadius())
end

function Seal:set_position(x, y)
    KBody.set_position(self, x, y)
    self.sprite:set_position(x, y)
end

return Seal