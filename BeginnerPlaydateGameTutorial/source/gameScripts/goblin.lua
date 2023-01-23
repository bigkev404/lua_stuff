import "gameScripts/enemy"

local pd <const> = playdate
local gfx <const> = playdate.graphics

class('Goblin').extends(Enemy)

function Goblin:init(x, y)
    local goblinImage = gfx.image.new("images/goblin")
    Goblin.super.init(self, x, y, goblinImage)

    self.health = 1
    self.attackDamage = 1
    self.speed = 1
end