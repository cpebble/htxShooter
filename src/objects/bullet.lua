bullet = {}

bullet.createBullet = function(x,y,dir, speed)
    local newBullet = {
        x = x,
        y = y,
        velocity = {x = dir.x *(speed or 1), y = dir.y*(speed or 1)},
        color = {25,25,255,100},
        width = 15,
        height = 15,
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

            if tabl.y < 200 then tabl = nil end
        end
    }
    print("shoot")
    return newBullet
end


return bullet
