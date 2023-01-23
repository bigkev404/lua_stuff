local pd <const> = playdate
local gfx <const> = playdate.graphics

class('Wall').extends(gfx.sprite)

function Wall:init(x, y, w, h)
    self:setSize(w, h)
    self:setCollideRect(0, 0, self:getSize())
    self:setCenter(0, 0)
    self:moveTo(x, y)
    self:setGroups(WALL_GROUP)
    self:add()
end