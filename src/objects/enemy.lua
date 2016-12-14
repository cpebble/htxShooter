--Original work by Christian Påbøl. Licensed under the MIT license ©
enemy = {}

local types = {--Objects = types of enemies: contains a list of points, health and graphic path
enem1 = {
    damage = 10,
    sprite = love.graphics.newImage("res/enem1.png"),
    scale=0.5,
    width = 104,
    height = 146,
    health = 1
},

}

enemy.createEnemy = function(x,y,velocity, type)
    local newEnemy = {
        x = x,
        y = y,
        type = types.enem1,
        velocity = velocity,

        hit = function(elem,dmg)
            elem.health = elem.health - dmg
            if elem.health <= 0 then
                elem.destroy(elem)
            end
            print("enemy hit")
        end,
        destroy = function(elem)
            local x = math.random(love.graphics.getWidth()*0.1, love.graphics.getWidth()*0.9)
            local y = -50
            table.insert(entities,enemy.createEnemy(x,y,{x=0, y=elem.velocity.y+20}))
            elem.toDestroy = true

        end,

        update = function(e,dt)
            e.x = e.x + e.velocity.x*dt
            e.y = e.y + e.velocity.y*dt
            if collision.isPolygonInside(getListOfPoints(e), {p1={x=player.x,y=player.y},p2={x=player.x+player.width, y=player.y+player.height}}) then --Check if it touches a player
                player.hit(e.damage)
                return false
            end
            return true
        end,

        draw = function(e)
            love.graphics.setColor(e.color)
            love.graphics.draw(e.sprite, e.x, e.y, math.pi, e.scale, e.scale, e.width*2, e.height*2)
            if(debug) then
                love.graphics.setColor(40, 255, 0,50)
                love.graphics.circle("fill", e.x, e.y, 5, 3)
                love.graphics.rectangle("fill", e.x, e.y, e.width, e.height)
            end
        end,
    }
    newEnemy.width = newEnemy.type.width*newEnemy.type.scale
    newEnemy.height = newEnemy.type.height*newEnemy.type.scale
    newEnemy.color = {255,255,255,255}
    newEnemy.health = newEnemy.type.health
    newEnemy.sprite = newEnemy.type.sprite
    newEnemy.hostile = true
    newEnemy.damage = newEnemy.type.damage
    newEnemy.scale = newEnemy.type.scale

    return newEnemy
end

return enemy
