bullet = {}

bullet.createBullet = function(x,y,dir, speed)
    local newBullet = {
        x = x,
        y = y,
        velocity = {x = dir.x *(speed or 1), y = dir.y*(speed or 1)},
        color = {25,25,255,255},
        width = 15,
        height = 15,
        hostile = false,
        damage = 1,
        draw = function(tabl) --Make a polygon from a triangle
            local x1 = tabl.x-tabl.width*0.5
            local y1 = tabl.y
            local x2 = x + tabl.width*0.5
            local y2 = tabl.y
            local x3 = tabl.x
            local y3 = tabl.y - tabl.height
            love.graphics.setColor(tabl.color)
            love.graphics.polygon("fill", x1,y1,x2,y2,x3,y3)
        end,
        update = function(tabl, dt)
            tabl.x = tabl.x + (tabl.velocity.x*dt)
            tabl.y = tabl.y + (tabl.velocity.y*dt)

            local x1 = tabl.x-tabl.width*0.5
            local y1 = tabl.y
            local x2 = x + tabl.width*0.5
            local y2 = tabl.y
            local x3 = tabl.x
            local y3 = tabl.y - tabl.height

            local poly = {{x=x1,y=y1},{x=x2,y=y2},{x=x3,y=y3}}
            for i,e in ipairs(entities) do
                if e.hostile then
                    if collision.isPolygonInside(poly, {p1={x=e.x,y=e.y},p2={x=e.x+e.width,y=e.y+e.height}}) then
                        e.hit(e,tabl.damage)
                        return false
                    end
                end
            end
            return true
        end
    }
    print("shoot")
    return newBullet
end


return bullet
