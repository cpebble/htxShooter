player = {}

player.createPlayer = function()
    player.x = love.graphics.getWidth()*0.5
    player.y = love.graphics.getHeight()*0.7
    player.width = 20
    player.height=30
    player.color = {20, 255, 20, 100}
    player.speed = 20
    player.velocity = {x = 0, y = 0}
    player.body =   love.physics.newBody(world, player.x, player.y, "dynamic")
    player.shape=   love.physics.newRectangleShape(player.width,player.height)
    player.fixture= love.physics.newFixture(player.body, player.shape, 1)
    player.body:setLinearDamping(0)
end

player.draw = function()
    print("Drawaing player at "..player.x..", "..player.y)
    love.graphics.setColor(player.color)
    print(player.body:getWorldPoints(player.shape:getPoints()))
    love.graphics.polygon("fill", player.body:getWorldPoints(player.shape:getPoints()));
end

player.update = function (dt)
    local velocity = {0,0}
    velocity[0] = 0
    velocity[1] = 0
    --Bringing global stuff into scope to save typing
    local isDown = love.keyboard.isDown
    local speed = player.speed
    --Calculate velocity from keyboard
    if isDown("w") then velocity[1] = 1*speed  elseif isDown("s") then velocity[1] = -1*speed end
    if isDown("a") then velocity[0] = -1*speed elseif isDown("d") then velocity[0] =  1*speed end

    player.body:setLinearVelocity(velocity[0],velocity[1])
    print(velocity[0],velocity[1])
    print(player.body:getLinearVelocity())
end
player.move = function(dir)
    if dir == "up" then
        player.velocity.y = 1*player.speed
    elseif dir == "down" then
        player.velocity.y =-1*player.speed
    end
    if dir == "left" then
        player.velocity.x = -1*player.speed
    elseif dir == "right" then
        player.velocity.x = 1*player.speed
    end
end


return player
