local Node = require('node')
local Sprite = require('sprite')

local Penguin = Node:new()

Penguin.sprite = Sprite:new()
Penguin.sprite:set_image('penguin.png')

function Penguin:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function Penguin:set_position(x, y)
    self.position.x = x
    self.position.y = y
end

function Penguin:move(x, y)
    self.position.x = self.position.x + x
    self.position.y = self.position.y + y
end

function Penguin:draw()
    Node.draw(self)
    Penguin.sprite:draw()
end

return Penguin