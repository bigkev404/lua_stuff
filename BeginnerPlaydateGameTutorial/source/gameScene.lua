import "gameScripts/player"
import "gameScripts/wall"
import "gameScripts/goblin"
import "gameScripts/screenShake"
import "gameScripts/enemySpawner"

function gameScene()
    local wallSize = 4
    local screenWidth = 400
    local screenHeight = 240
    Wall(0, 0, wallSize, screenHeight) -- Left Wall
    Wall(screenWidth - wallSize, 0, wallSize, screenHeight) -- Right Wall
    Wall(0, 0, screenWidth, wallSize) -- Top Wall
    Wall(0, screenHeight - wallSize, screenWidth, wallSize) -- Bottom Wall
    Player(200, 120)
    EnemySpawner()
    ScreenShake()
end