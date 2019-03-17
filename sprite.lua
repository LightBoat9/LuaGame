local Node = require('node')
local Sprite = Node:new()

function Sprite:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function Sprite:draw()
    Node.draw(self)
    love.graphics.push()
    love.graphics.scale(self.scale.x, self.scale.y)
    if self.image then
        love.graphics.draw(self.image, self.position.x, self.position.y)
    end
    love.graphics.pop()
end

function Sprite:set_image(image_path)
    self.image = love.graphics.newImage(image_path)
    self.image:setFilter('nearest')
end

return Sprite