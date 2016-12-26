local background = {}

local spriteWidth = 32
local waterTile = love.graphics.newImage("res/waterTile.png")
local xSpriteWidth = math.ceil(love.graphics.getWidth()/spriteWidth)+1
local ySpriteWidth = math.ceil(love.graphics.getHeight()/spriteWidth)+1
local maxSprites = (xSpriteWidth*ySpriteWidth + xSpriteWidth)
local backgroundBatch = love.graphics.newSpriteBatch(waterTile, maxSprites)

local offset = 0 -- value 0-32
local scrollSpeed = 150

local spritesDrawn ={}
--fills up the screen

for x=0, xSpriteWidth do
    for y=-1, ySpriteWidth do
        local id = backgroundBatch:add(x*spriteWidth, y*spriteWidth)
        table.insert(spritesDrawn, {id = id, x=x*spriteWidth, y = y*spriteWidth})
    end
end
local function addTopRow() --Add another row of sprites one layer above the screen
    local y = 0-spriteWidth
    for x = 0, xSpriteWidth do
        backgroundBatch:add(x*spriteWidth, y)
    end
end

background.update = function(dt)
    offset = (offset+dt*scrollSpeed) % 32

end

background.draw = function()
    if debug then
        for x=0, xSpriteWidth do
            for y=0, ySpriteWidth do
                --love.graphics.rectangle("line", x*spriteWidth, y*spriteWidth, spriteWidth, spriteWidth)
            end
        end
    end
    for _, id in ipairs(spritesDrawn) do
        --print(id.id, id.x, id.y)
        backgroundBatch:set(id.id, id.x, id.y, 0, 1, 1,0, -offset, 0, 0)
    end
    -- for i = 0
    love.graphics.setColor(255, 255, 255)
    --love.graphics.draw(waterTile, 0, 0)
    love.graphics.draw(backgroundBatch) --Draw the batch with the scrolling offset
    print(offset)
end


return background
