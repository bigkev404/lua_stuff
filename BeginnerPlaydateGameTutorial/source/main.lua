import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

import "sceneManager"
import "gameScene"
import "titleScene"

local pd <const> = playdate
local gfx <const> = playdate.graphics

PLAYER_GROUP = 1
BULLET_GROUP = 2
ENEMY_GROUP = 3
WALL_GROUP = 4

function setShakeAmount(amount)
    shakeAmount = amount
end

local function initialize()
    sceneManager = SceneManager()
    TitleScene()
end

initialize()

function playdate.update()
    gfx.sprite.update()
    playdate.timer.updateTimers()
end
