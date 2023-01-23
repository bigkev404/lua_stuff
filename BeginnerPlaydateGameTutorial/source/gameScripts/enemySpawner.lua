import "gameScripts/goblin"

local pd <const> = playdate
local gfx <const> = playdate.graphics

class('EnemySpawner').extends(gfx.sprite)

function EnemySpawner:init()
    math.randomseed(pd.getSecondsSinceEpoch())
    self.spawnTimeMin = 2000
    self.spawnTimeMax = 3000
    self.spawnLocations = {
        {200, 20},
        {200, 210},
        {20, 120},
        {380, 120}
    }

    self:setSpawnTime()
    self:add()
end

function EnemySpawner:setSpawnTime()
    self.spawnTimeMin = math.max(60 - SCORE, 15)
    self.spawnTimeMax = math.max(90 - SCORE, 45)
    self.spawnCounter = math.random(self.spawnTimeMin, self.spawnTimeMax)
end

function EnemySpawner:spawnEnemy()
    local spawnLocationIndex = math.random(#self.spawnLocations)
    local spawnLocation = self.spawnLocations[spawnLocationIndex]
    local spawnX = spawnLocation[1]
    local spawnY = spawnLocation[2]
    Goblin(spawnX, spawnY)
end

function EnemySpawner:update()
    self.spawnCounter -= 1
    if self.spawnCounter <= 0 then
        self:setSpawnTime()
        self:spawnEnemy()
    end
end