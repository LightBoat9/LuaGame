local Node = require('node')
local Sprite = require('sprite')

local Penguin = Node:new()

Penguin.sprite = Sprite:new()
Penguin.sprite:set_image('penguin.png')
Penguin.sprite:set_centered(true)
Penguin.velocity = 0 -- Penguin only moves up and down
Penguin.max_velocity = 300
Penguin.acceleration = 500

function Penguin:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function Penguin:update(delta)
    local v_input = (love.keyboard.isDown('down') and 1 or 0) - (love.keyboard.isDown('up') and 1 or 0)
    
    self.velocity = self.velocity + (self.acceleration * delta * (self.position.y < 150 and 1 or v_input))
    self.velocity = math.min(math.max(self.velocity, -self.max_velocity), self.max_velocity)
    self:move(0, self.velocity * delta)

    local width, height = love.graphics.getDimensions()
    self:set_position(self.position.x, math.min(math.max(self.position.y, 0), height - 50))

    
    if self.velocity > self.max_velocity / 2 then
        self.sprite:set_rotation(0.5)
    elseif self.velocity < -self.max_velocity / 2 then
        self.sprite:set_rotation(-0.5)
    else
        self.sprite:set_rotation(0)
    end
end

function Penguin:move(x, y)
    self:set_position(self.position.x + x, self.position.y + y)
end

function Penguin:draw()
    Node.draw(self)
    Penguin.sprite:draw()
end

function Penguin:set_position(x, y)
    self.position.x = x
    self.position.y = y
end


return Penguin