enemy = {}

enemy.createEnemy = function(x,y)
    local newEnemy = {
        x = x,
        y = y,
        velocity = {x=0,y=0},
        width = math.random(10, 50),
        height = math.random(10,50),
        color = {255,0,0,100},
        damage = 10,
        hostile = true,

        hit = function(elem,dmg)
            elem.toDestroy = true
            print("enemy hit")
        end,

        update = function(e,dt)
            x = x + e.velocity.x*dt
            y = y + e.velocity.y*dt
            if collision.isPolygonInside(getListOfPoints(e), {p1={x=player.x,y=player.y},p2={x=player.x+player.width, y=player.y+player.height}}) then --Check if it touches a player
                player.hit(e.damage)
                return false
            end
            return true
        end
    }

    return newEnemy

end --TODO: implement Logic

return enemy
