local pd <const> = playdate
local gfx <const> = playdate.graphics

class('Enemy').extends(gfx.sprite)

function Enemy:init(x, y, image)
    self:setImage(image)
    self:moveTo(x, y)
    self:add()

    self:setCollideRect(0, 0, self:getSize())
    self:setGroups(ENEMY_GROUP)
    self:setCollidesWithGroups({WALL_GROUP, PLAYER_GROUP})
end

function Enemy:damage(amount)
    setShakeAmount(5)
    self.health -= amount
    if self.health <= 0 then
        self:remove()
        return true
    end
    return false
end

function Enemy:update()
    local xDirection = PLAYER_X - self.x
    local yDirection = PLAYER_Y - self.y
    local directionLength = math.sqrt(xDirection^2 + yDirection^2)
    if directionLength ~= 0 then
        xDirection = xDirection * self.speed / directionLength
        yDirection = yDirection * self.speed / directionLength
        local actualX, actualY, collisions, length = self:moveWithCollisions(self.x + xDirection, self.y + yDirection)
        if length > 0 then
            for index, collision in pairs(collisions) do
                local collidedObject = collision['other']
                if collidedObject:isa(Player) then
                    if self:alphaCollision(collidedObject) then
                        collidedObject:damage(self.attackDamage)
                        self:remove()
                    end
                end
            end
        end
    end
end

function Enemy:collisionResponse(other)
    if other:isa(Player) then
        return "overlap"
    end
    return "slide"
end