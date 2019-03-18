--- Simple implementation of a kinematic body

local Node = require('node')
local KBody = Node:new()

function KBody:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end