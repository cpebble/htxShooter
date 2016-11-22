enemy = {}

enemy.createEnemy = function(x,y)
    local newEnemy = {
        x = x,
        y = y,
        velocity = {x=0,y=0},
        width = math.random(10, 50),
        color = {255,0,0,100}
    }

    return newEnemy

end --TODO: implement Logic

return enemy
