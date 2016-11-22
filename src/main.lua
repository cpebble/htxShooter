
debug = true --Debug mode
isPaused = false --Variable to check for paused

local player = require "objects.player"
local bullet = require "objects.bullet"
--local keyboard = require "keyboard"

entities = {}

function love.load()
    love.graphics.setBackgroundColor(30, 30, 255, 100)
    player.createPlayer(entities)
    table.insert(entities, player)
end

function love.update(dt)
    if not isPaused then
        --Loop through entities creating bullets.
        for i,e in ipairs(entities) do
            if type(e.update) == "function" then e.update(e,dt) else
                if e.velocity then
                    e.x = e.x + (e.velocity.x*dt)
                    e.y = e.y + (e.velocity.y*dt)
                end
            end
        end

    end

end

function love.draw()
  for i,e in ipairs(entities) do
      if type(e.draw) == "function" then e.draw(e) else
          love.graphics.setColor(e.color)
          love.graphics.circle("fill", e.x, e.y, e.width or 20)
      end


  end

end
function love.keypressed(key, scancode, isrepeat)

    checkKeybinds(key)
end



function checkKeybinds(key)
    local keybinds = {
        ['p'] = pause,
        ['q'] = quit,
    }


  local k = type(keybinds[key]) == "function" and keybinds[key]() or print(key.." Not defined")
      print(key.." pressed", keybinds[key])
end

function quit()
    love.event.quit("exit")
end
function pause()
    isPaused = not isPaused
end