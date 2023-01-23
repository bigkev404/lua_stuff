local pd <const> = playdate
local gfx <const> = playdate.graphics

class('SceneManager').extends(gfx.sprite)

function SceneManager:init()
    self:setCenter(0, 0)
    self:setZIndex(100)
    self.transitionTime = 700
    self.transitioningIn = false
end

function SceneManager:switchScene(scene)
    if self.transitioningIn then
        return
    end
    self.transitionAnimator = gfx.animator.new(self.transitionTime, 0, 400, pd.easingFunctions.outCubic)
    self.transitioningIn = true
    self.newScene = scene
    self:add()
end

function SceneManager:loadNewScene()
    gfx.sprite.removeAll()
    self:add()
    self.transitionAnimator = gfx.animator.new(self.transitionTime, 400, 0, pd.easingFunctions.inCubic)
    self.transitioningIn = false
    self.newScene()
end

function SceneManager:update()
    if self.transitionAnimator then
        local transitionImage = gfx.image.new(400, 240)
        gfx.pushContext(transitionImage)
            gfx.fillRect(0, 0, self.transitionAnimator:currentValue(), 240)
        gfx.popContext(transitionImage)
        self:setImage(transitionImage)
        if self.transitioningIn and self.transitionAnimator:ended() then
            self:loadNewScene()
        end
    end
end