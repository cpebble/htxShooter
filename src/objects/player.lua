player = {}

local bullet = require "objects.bullet"

player.sprite = love.graphics.newImage("res/player.png")

player.createPlayer = function(ent)
    local entities = ent --Bring the table of entities to a local scope
    player.x = love.graphics.getWidth()*0.5
    player.y = love.graphics.getHeight()*0.7
    player.scale = 0.5
    player.width = player.sprite:getWidth()*player.scale
    player.height= player.sprite:getHeight()*player.scale
    player.color = {255,255,255,255}
    player.speed = 250
    player.health = 100
    player.score = 0
    player.hostile = false --To be destroyed by friendly bullets
    player.shotSpeed = 0.2
    player.shotLocation = {}
    player.shotLocation = function() --Return the location of where we want our player to shoot
        local location = {}
        location.x = player.x + (0.5*player.width)
        location.y = player.y
        return location
    end

    player.score = 0
    player.nextShot = love.timer.getTime() + player.shotSpeed
end

player.addScore = function(inc)
    player.score = player.score + inc
end

player.hit = function(health)
    player.health = player.health - health
    if player.health <= 0 then
        player.speed = 0
        player.color = {0,0,0,0}
        player.x = -player.width
        player.y = -player.height
    end
end

player.draw = function()
    --print("Drawaing player at "..player.x..", "..player.y)
    love.graphics.setColor(player.color)
    -- love.graphics.rectangle("fill", player.x, player.y, player.width, player.height)
    love.graphics.draw(player.sprite, player.x, player.y, 0, player.scale, player.scale)
    if(debug) then
        love.graphics.setColor(40, 255, 0,100)
        love.graphics.circle("fill", player.x, player.y, 5, 3)
        love.graphics.circle("fill", player.shotLocation().x, player.shotLocation().y, 5, 5)
        love.graphics.rectangle("line", player.x, player.y, player.width, player.height)
    end
    --print(player.body:getWorldPoints(player.shape:getPoints()))
    --love.graphics.polygon("fill", player.body:getWorldPoints(player.shape:getPoints()));
end

player.update = function (tabl,dt)
    --print("playerUpdate")
    local velocity = {0,0}
    velocity[0] = 0
    velocity[1] = 0
    --Bringing global stuff into scope to save typing
    local isDown = love.keyboard.isDown
    local speed = player.speed
    --Calculate velocity from keyboard
    if isDown("w", "up") then velocity[1] = -1*speed elseif isDown("s", "down") then velocity[1] = 1*speed end
    if isDown("a", "left") then velocity[0] = -1*speed elseif isDown("d", "right") then velocity[0] =  1*speed end

    if isDown("space") then player.shoot()  end

    player.y = player.y+(velocity[1]*dt);
    player.x = player.x+(velocity[0]*dt);
    --Clamp these values within the game window
    player.x = math.min(math.max(player.x, 0), love.graphics.getWidth()-player.width)
    player.y = math.min(math.max(player.y, 0), love.graphics.getHeight()-player.height)
    --function math.clamp(low, n, high) return math.min(math.max(n, low), high) end
    return true
end
player.shoot = function() -- Returns the bullet object
    if love.timer.getTime() < player.nextShot then return false else -- now is not the time to shoot
        local spawn = player.shotLocation()
        table.insert(entities, bullet.createBullet(spawn.x, spawn.y, {x=0, y=-500}, 0.7))
        --print(love.timer.getTime(), player.nextShot)
        player.nextShot = love.timer.getTime() + player.shotSpeed
    end
end
player.move = function(dir)
--     print(dir)
--     if dir == "up" then
--         player.velocity.y = 1*player.speed
--     elseif dir == "down" then
--         player.velocity.y =-1*player.speed
--     end
--     if dir == "left" then
--         player.velocity.x = -1*player.speed
--     elseif dir == "right" then
--         player.velocity.x = 1*player.speed
--     end
--
end


return player
