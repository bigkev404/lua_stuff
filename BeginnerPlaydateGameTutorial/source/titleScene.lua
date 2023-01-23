local pd <const> = playdate
local gfx <const> = playdate.graphics

class('TitleScene').extends(gfx.sprite)

function TitleScene:init()
    local backgroundImage = gfx.image.new("images/titleScreen")
    self:setCenter(0, 0)
    self:setImage(backgroundImage)
    self:add()
end

function TitleScene:update()
    if pd.buttonJustPressed(pd.kButtonA) then
        sceneManager:switchScene(gameScene)
    end
end