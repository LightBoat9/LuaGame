local Sprite = require('sprite')
local Seal = {}

function Seal:new(world, x, y)
    local o = {}
    setmetatable(o, self)
    self.__index = self

    o.sprite = Sprite:new()
    o.sprite:set_image('seal.png')
    o.sprite:set_centered(true)

    o.body = love.physics.newBody(world, x, y, 'dynamic')
    o.shape = love.physics.newCircleShape(48)
    o.fixture = love.physics.newFixture(o.body, o.shape)
    o.fixture:setUserData(o)
    o.name = 'seal'
    o.fixture:setSensor(true)

    -- Exists on category 2 and does not collide with category 3
    o.fixture:setCategory(2)
    o.fixture:setMask(3)
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