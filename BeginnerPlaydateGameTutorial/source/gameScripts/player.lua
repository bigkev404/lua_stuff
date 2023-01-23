import "gameScripts/bullet"

local pd <const> = playdate
local gfx <const> = playdate.graphics

class('Player').extends(gfx.sprite)

function Player:init(x, y)
    self.speed = 2
    self.bulletSpeed = 6
    self.bulletDamage = 1
    self.canFire = true
    self.cooldown = 400

    self.lastDirectionX = 1
    self.lastDirectionY = 0

    self.healthSprite = gfx.sprite.new()
    self.healthSprite:add()
    self.healthSprite:setCenter(0, 0)
    self.healthSprite:moveTo(2, 2)
    self.health = 5
    self:updateHealthDisplay()

    self.scoreSprite = gfx.sprite.new()
    self.scoreSprite:add()
    self.scoreSprite:setCenter(0, 0)
    self.scoreSprite:moveTo(320, 2)
    self.score = 0
    self:updateScoreDisplay()

    local playerImage = gfx.image.new("images/player")
    self:setImage(playerImage)
    self:moveTo(x, y)
    self:add()

    self:setCollideRect(0, 0, self:getSize())
    self:setGroups(PLAYER_GROUP)
    self:setCollidesWithGroups({WALL_GROUP, ENEMY_GROUP})
end

function Player:damage(amount)
    setShakeAmount(8)
    self.health -= amount
    self:updateHealthDisplay()
    if self.health <= 0 then
        self:die()
    end
end

function Player:die()
    self:remove()
    sceneManager:switchScene(TitleScene)
end

function Player:updateHealthDisplay()
    local hpText = "HP: " .. self.health
    local textWidth, textHeight = gfx.getTextSize(hpText)
    local healthImage = gfx.image.new(textWidth, textHeight)
    gfx.pushContext(healthImage)
        gfx.drawText(hpText, 0, 0)
    gfx.popContext()
    self.healthSprite:setImage(healthImage)
end

function Player:updateScoreDisplay()
    SCORE = self.score
    local scoreText = "Score: " .. self.score
    local textWidth, textHeight = gfx.getTextSize(scoreText)
    local scoreImage = gfx.image.new(textWidth, textHeight)
    gfx.pushContext(scoreImage)
        gfx.drawText(scoreText, 0, 0)
    gfx.popContext()
    self.scoreSprite:setImage(scoreImage)
end

function Player:incrementScore()
    self.score += 1
    self:updateScoreDisplay()
end

function Player:update()
    local xDirection = 0
    local yDirection = 0
    if pd.buttonIsPressed(pd.kButtonLeft) then
        xDirection -= 1
    end
    if pd.buttonIsPressed(pd.kButtonRight) then
        xDirection += 1
    end
    if pd.buttonIsPressed(pd.kButtonUp) then
        yDirection -= 1
    end
    if pd.buttonIsPressed(pd.kButtonDown) then
        yDirection += 1
    end
    local directionLength = math.sqrt(xDirection^2 + yDirection^2)
    if directionLength ~= 0 then
        xDirection = xDirection * self.speed / directionLength
        yDirection = yDirection * self.speed / directionLength
        self.lastDirectionX = xDirection
        self.lastDirectionY = yDirection
        self:moveWithCollisions(self.x + xDirection, self.y + yDirection)
    end

    if pd.buttonIsPressed(pd.kButtonA) and self.canFire then
        Bullet(self, self.x, self.y, self.lastDirectionX, self.lastDirectionY, self.bulletSpeed, self.bulletDamage)
        self.canFire = false
        pd.timer.new(self.cooldown, function()
            self.canFire = true
        end)
    end

    PLAYER_X = self.x
    PLAYER_Y = self.y
end

function Player:collisionResponse(other)
    if other:isa(Enemy) then
        return "overlap"
    end
    return "slide"
end