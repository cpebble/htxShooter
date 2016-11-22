collision = {}

collision.isPointInside = function(point,rectangle)--Rectangle = {p1 = {x,y}, p2 = {x,y}} øverste venstre og nederste højre
--First check x, then check y
    if point.x >= rectangle.p1.x and point.x <= rectangle.p2.x and point.y >= rectangle.p1.y and point.y <= rectangle.p2.y then
        return true
    end
    return false
end
collision.isRectangleInside = function(a, rectangle) --a = a list of points

    for i,p in ipairs(rectangle) do

    end

end


return collision
