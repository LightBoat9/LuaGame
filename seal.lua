local Sprite = require('sprite')
local Seal = {}

function Seal:new(world, x, y)
    self.sprite = Sprite:new()
    self.sprite:set_image('seal.png')
    self.sprite:set_centered(true)
    
    o = {}
    setmetatable(o, self)
    self.__index = self

    self.body = love.physics.newBody(world, x, y, 'dynamic')
    self.shape = love.physics.newCircleShape(64)
    self.fixture = love.physics.newFixture(self.body, self.shape)
    self.fixture:setUserData('seal')
    self.fixture:setSensor(true)

    -- Exists on category 2 and does not collide with category 3
    self.fixture:setCategory(2)
    self.fixture:setMask(3)

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

return Seal