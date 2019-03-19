--- A penguin KBody that can move up and down also
--- Stops at the bottom of the screen
--- If above a defined sea level it will be forced back down

local Sprite = require('sprite')

local Penguin = {}

function Penguin:new(world, x, y)
    o = {}
    setmetatable(o, self)
    self.__index = self
    self.body = love.physics.newBody(world, x, y)
    return o
end

Penguin.sprite = Sprite:new()
Penguin.sprite:set_image('penguin.png')
Penguin.sprite:set_centered(true)

Penguin.velocity = 0 -- Penguin only moves up and down
Penguin.max_velocity = 300
Penguin.acceleration = 500
Penguin.rotate_limit = 0.2 -- Percentage of velocity required for the sprite to rotate

-- Distance from the top of the screen that dictates sea level
-- If the penguin is above this the penguin is forced to accelerate down
Penguin.sea_level = 150 

function Penguin:update(delta)
    -- Get user input 1 if only down is pressed and -1 if only up is pressed 0 otherwise
    local v_input = (love.keyboard.isDown('down') and 1 or 0) - (love.keyboard.isDown('up') and 1 or 0)
    

    -- Increase the velocity by acceleration
    -- If above sea level an input of 1 is forced to mimic gravity
    --[[
    self.velocity = self.velocity + (self.acceleration * delta * (self.position.y < Penguin.sea_level and 1 or v_input))
    self.velocity = math.min(math.max(self.velocity, -self.max_velocity), self.max_velocity)
    self:move(0, self.velocity * delta)

    local width, height = love.graphics.getDimensions()
    self:set_position(self.position.x, math.min(math.max(self.position.y, 0), height - 50))

    
    -- Rotate based on the velocity
    if self.velocity > self.max_velocity * self.rotate_limit then
        self.sprite:set_rotation(0.5)
    elseif self.velocity < -self.max_velocity * self.rotate_limit then
        self.sprite:set_rotation(-0.5)
    else
        self.sprite:set_rotation(0)
    end
    --]]
end

function Penguin:draw()
    Penguin.sprite:draw()
end

--- Overwites parent set_position so that the position of the child sprite
--- is the same as this node
function Penguin:set_position(x, y)
    KBody.set_position(self, x, y) -- Also call parents method
    self.sprite:set_position(x, y)
end

return Penguin