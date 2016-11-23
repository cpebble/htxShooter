collision = {}

collision.isPointInside = function(point,rectangle)
--Point = {x,y}
--Rectangle = {p1 = {x,y}, p2 = {x,y}} øverste venstre og nederste højre

--Check p1.x < x < p2.x and p1.y < y < p2.y
    if point.x >= rectangle.p1.x
    and point.x <= rectangle.p2.x
    and point.y >= rectangle.p1.y
    and point.y <= rectangle.p2.y then
        return true
    end
    return false
end
collision.isPolygonInside = function(a, rectangle) --a = a list of points
    isInside = false
    for i,p in ipairs(a) do
        print(p)
        if not isInside then isInside = collision.isPointInside(p, rectangle) end
    end
    return isInside

end

return collision
