local pd <const> = playdate
local gfx <const> = playdate.graphics

class('Bullet').extends(gfx.sprite)

function Bullet:init(player, x, y, xDir, yDir, speed, bulletDamage)
    self.player = player
    local bulletSize = 4
    local bulletImage = gfx.image.new(bulletSize * 2, bulletSize * 2)
    gfx.pushContext(bulletImage)
        gfx.drawCircleAtPoint(bulletSize, bulletSize, bulletSize)
    gfx.popContext()
    self:setImage(bulletImage)

    self:setCollideRect(0, 0, self:getSize())
    self:setGroups(BULLET_GROUP)
    self:setCollidesWithGroups({WALL_GROUP, ENEMY_GROUP})

    local directionLength = math.sqrt(xDir^2 + yDir^2)
    self.xDir = xDir / directionLength
    self.yDir = yDir / directionLength
    self.speed = speed

    self.bulletDamage = bulletDamage

    local spawnOffset = 10
    self:moveTo(x + self.xDir * spawnOffset, y + self.yDir * spawnOffset)
    self:add()
end

function Bullet:update()
    local actualX, actualY, collisions, length = self:moveWithCollisions(self.x + self.xDir * self.speed, self.y + self.yDir * self.speed)
    if length > 0 then
        for index, collision in pairs(collisions) do
            local collidedObject = collision['other']
            if collidedObject:isa(Enemy) then
                local killed = collidedObject:damage(self.bulletDamage)
                if killed then
                    self.player:incrementScore()
                end
            end
        end
        self:remove()
    end
end