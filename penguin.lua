Penguin = {
    image = love.graphics.newImage('penguin.png'),
    x = 0,
    y = 0,
}

print(Penguin)

function Penguin:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function Penguin:set_position(x, y)
    self.x = x
    self.y = y
end

function Penguin:draw()
    love.graphics.draw(self.image, self.x, self.y)
end

return Penguin