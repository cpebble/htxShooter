gui = {}

local HUD = {
    health = {
        x = 50,
        y = love.graphics.getHeight()*0.9,
        draw = function(elem)
            local health = player.health
            local barWidth = love.graphics.getWidth() / 5
            local greenWidth = (health) * (barWidth) / (100 - 0)
            local barHeight = 30
            love.graphics.setColor(255, 0, 0, 50) --Red health bar
            love.graphics.rectangle("fill", elem.x, elem.y, barWidth, barHeight)
            love.graphics.setColor(0,255,0,100) --Green healthbar
            love.graphics.rectangle("fill", elem.x, elem.y, greenWidth, barHeight)
        end
    }

} --List of objects to display as the HUD

gui.drawHUD = function()
    for i,e in pairs(HUD) do
        e.draw(e)

    end
end
return gui
