local Sprite = require('sprite')
local Fish = {}

Fish.sprite = Sprite:new()
Fish.sprite:set_image('fish.png')
Fish.sprite:set_centered(true)

function Fish:new(world, x, y)
    o = {}
    setmetatable(o, self)
    self.__index = self
    self.body = love.physics.newBody(world, x, y, 'dynamic')
    self.shape = love.physics.newCircleShape(32)
    self.fixture = love.physics.newFixture(self.body, self.shape)
    self.fixture:setUserData('fish')
    self.fixture:setSensor(true)

    -- Exists on category 2 and does not collide with category 3
    self.fixture:setCategory(2)
    self.fixture:setMask(3)
    return o
end

function Fish:update(delta)
    self.body:setLinearVelocity(-250, 0)
    if self.body:getX() <= 0 then
        width, _ = love.graphics.getDimensions()
        self.body:setX(width)
    end
end

function Fish:draw()
    self.sprite:draw(self.body:getX(), self.body:getY())
    love.graphics.circle('line', self.body:getX(), self.body:getY(), self.shape:getRadius())
end

return Fish