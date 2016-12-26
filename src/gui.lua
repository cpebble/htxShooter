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
    },
    score = {
        x = 0,
        y = 50,
        scale = 10,
        font = love.graphics.newImageFont("res/font.png", " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,!?-+/():;%&`'*#=[]\""),
        draw = function(elem)
            local score = player.score
            love.graphics.setFont(elem.font)
            love.graphics.setColor(40,255,0,255)
            love.graphics.printf(player.score, elem.x, elem.y, love.graphics.getWidth(), "center", 0)

        end
    }

} --List of objects to display as the HUD

gui.drawHUD = function()
    for i,e in pairs(HUD) do
        e.draw(e)

    end
end
return gui
