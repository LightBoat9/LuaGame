local Node = {
    position = { x = 0, y = 0 },
    scale = { x = 1, y = 1 },
    rotation = 0, -- radians
}

function Node:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function Node:update(delta)
end

function Node:draw()
    love.graphics.push()
    love.graphics.scale(self.scale.x, self.scale.y)
    love.graphics.pop()
end

function Node:set_scale(x, y)
    self.scale = { x = x, y = y }
end

function Node:set_rotation(rot)
    self.rotation = rot
end

function Node:set_position(x, y)
    self.position = { x = x, y = y }
end

return Node