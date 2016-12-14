local background = {}

local spriteWidth = 32
local waterTile = love.graphics.newImage("res/waterTile.png")
local xSpriteWidth = math.ceil(love.graphics.getWidth()/spriteWidth)
local ySpriteWidth = math.ceil(love.graphics.getHeight()/spriteWidth)
local maxSprites = (xSpriteWidth*ySpriteWidth)*2
local backgroundBatch = love.graphics.newSpriteBatch(waterTile, maxSprites)

local offset = 0 -- value 0-32
local scrollSpeed = 5


--fills up the screen
for x=0, xSpriteWidth do
    for y=0, ySpriteWidth do
        backgroundBatch:add(x*spriteWidth, y*spriteWidth)
        print(x,y)
    end
end

local function addTopRow() --Add another row of sprites one layer above the screen
    local y = 0-spriteWidth
    for x = 0, xSpriteWidth do
        backgroundBatch:add(x*spriteWidth, y)
    end
end

background.update = function(dt)
    offset = offset+dt*scrollSpeed
    --if offset >31 then addTopRow() end
end

background.draw = function()
    for x=0, xSpriteWidth do
        for y=0, ySpriteWidth do
            --love.graphics.rectangle("line", x*spriteWidth, y*spriteWidth, spriteWidth, spriteWidth)
        end
    end
    love.graphics.setColor(255, 255, 255)
    --love.graphics.draw(waterTile, 0, 0)
    love.graphics.draw(backgroundBatch, 0, 0, 0, 1, 1, 0, offset) --Draw the batch with the scrolling offset
end


return background
