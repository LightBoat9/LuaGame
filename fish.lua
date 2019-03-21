local Sprite = require('sprite')
local Fish = {}

Fish.sprite = Sprite:new()
Fish.sprite:set_image('fish.png')
Fish.sprite:set_centered(true)

function Fish:new(world, x, y)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    
    o.body = love.physics.newBody(world, x, y, 'dynamic')
    o.shape = love.physics.newCircleShape(32)
    o.fixture = love.physics.newFixture(o.body, o.shape)
    o.fixture:setUserData(o)
    o.name = 'fish'
    o.fixture:setSensor(true)

    -- Exists on category 2 and does not collide with category 3
    o.fixture:setCategory(2)
    o.fixture:setMask(3)
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