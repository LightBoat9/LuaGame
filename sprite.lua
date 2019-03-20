--- extention of node that has a texture

local Sprite = {
    rotation = 0,
}

Sprite.centered = false

function Sprite:new()
    o = {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function Sprite:draw(x, y)
    if self.image then
        width, height = self:get_size()
        love.graphics.draw(self.image, x, y, self.rotation, 1, 1, self.centered and width/2 or 0, self.centered and height/2 or 0)
    end
end

-- Set the image for this sprite, optional filter defaults to nearest
function Sprite:set_image(image_path, filter)
    self.image = love.graphics.newImage(image_path)
    self.image:setFilter(filter and filter or 'nearest')
end

--- return the size (width, height) of this sprites image in pixels
function Sprite:get_size()
    if self.image then
        return self.image:getWidth(), self.image:getHeight()
    end
    return 0, 0
end

function Sprite:set_rotation(rot)
    self.rotation = rot
end

function Sprite:set_centered(centered)
    self.centered = centered
end

return Sprite