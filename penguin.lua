--- A penguin KBody that can move up and down also
--- Stops at the bottom of the screen
--- If above a defined sea level it will be forced back down
local Sprite = require('sprite')
local Penguin = {}

function Penguin:new(world, x, y)
    o = {}
    setmetatable(o, self)
    self.__index = self
    
    o.shape = love.physics.newCircleShape(15)
    o.body = love.physics.newBody(world, x, y, 'dynamic')
    o.fixture = love.physics.newFixture(o.body, o.shape)
    o.fixture:setUserData(o)
    o.name = 'penguin'

    o.fixture:setSensor(true)

    -- Exists on category 1
    o.fixture:setCategory(1)
    return o
end

Penguin.sprite = Sprite:new()
Penguin.sprite:set_image('penguin.png')
Penguin.sprite:set_centered(true)

Penguin.velocity = 0 -- Penguin only moves up and down
Penguin.max_velocity = 300
Penguin.acceleration = 500
Penguin.rotation = 0
Penguin.rotate_limit = 0.2 -- Percentage of velocity required for the sprite to rotate

-- Distance from the top of the screen that dictates sea level
-- If the penguin is above this the penguin is forced to accelerate down
Penguin.sea_level = 150 

function Penguin:update(delta)
    -- Get user input 1 if only down is pressed and -1 if only up is pressed 0 otherwise
    local v_input = (love.keyboard.isDown('down') and 1 or 0) - (love.keyboard.isDown('up') and 1 or 0)

    -- Increase the velocity by acceleration
    -- If above sea level an input of 1 is forced to mimic gravity
    self.velocity = self.velocity + (self.acceleration * delta * (self.body:getY() < Penguin.sea_level and 1 or v_input))
    self.velocity = math.min(math.max(self.velocity, -self.max_velocity), self.max_velocity)
    self.body:setLinearVelocity(0, self.velocity)

    local width, height = love.graphics.getDimensions()
    self.body:setY(math.min(math.max(self.body:getY(), 0), height - 50))

    -- Rotate sprite based on velocity
    self.sprite:set_rotation(self.velocity / self.max_velocity)
end

function Penguin:draw()
    Penguin.sprite:draw(self.body:getX(), self.body:getY())
    --love.graphics.circle('line', self.body:getX(), self.body:getY(), self.shape:getRadius())
end

return Penguin