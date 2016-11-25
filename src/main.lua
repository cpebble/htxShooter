
debug = true --Debug mode
isPaused = false --Variable to check for paused

-- Gamestate = require "hump.gamestate"

local bullet = require "objects.bullet"
local enemy  = require "objects.enemy"
local player = require "objects.player"

local gui =    require "gui"

local collision = require "collision"
entities = {}

function love.load()
    -- love.graphics.setBackgroundColor(110, 110, 255, 100)
    player.createPlayer(entities)
    table.insert(entities, player)

    for i = 0, 5 do
        local x = math.random(love.graphics.getWidth()*0.1, love.graphics.getWidth()*0.9)
        local y = math.random(0, love.graphics.getHeight()*0.5)
        table.insert(entities,enemy.createEnemy(x,y))
    end

end

function love.update(dt)
    if not isPaused then
        --Loop through entities creating bullets.
        local toDestruct = {}
        for i,e in ipairs(entities) do
            if type(e.update) == "function" then  if not e.update(e,dt) then table.insert(toDestruct,i) end else
                if e.velocity then
                    e.x = e.x + (e.velocity.x*dt)
                    e.y = e.y + (e.velocity.y*dt)
                end
            end
            --Now check if any entities are of screen
            if not collision.isPointInside({x = e.x, y=e.y}, {p1={x = 0-love.graphics.getWidth()*0.2,y = 0-love.graphics.getHeight()*0.2}, p2 = {x = love.graphics.getWidth()*1.2, y = love.graphics.getHeight()*1.2}}) then --Checks if the objects x and y coordinates is within 120% of the game window
                print("Element at "..e.x..","..e.y.." Destroyed")
                table.insert(toDestruct, i)
            end
            if e.toDestroy == true then table.insert(toDestruct, i) end
        end
        for i, e in ipairs(toDestruct) do
            table.remove(entities, e)
        end
        toDestruct = nil
    end

end


--Drawing entities:
--1. test if the entity already has a draw function and execute
--2. test if the entity has a height, the draw a rectangle using height and (width or height)
--3. if that fails, draw a circle at the x-y with the width as radius or 20 if that isn't set
function love.draw()
  for i,e in ipairs(entities) do
      if type(e.draw) == "function" then e.draw(e) else
          love.graphics.setColor(e.color)
          if e.height then --if we want a square define both height and width
              love.graphics.rectangle("fill", e.x, e.y, e.width or e.height, e.height)
          else
              love.graphics.circle("fill", e.x, e.y, e.width or 20)
          end
      end
  end
  gui.drawHUD()

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

function getListOfPoints(elem)
    local list = {
        {x=elem.x,y=elem.y},
        {x=elem.x+elem.width,y=elem.y},
        {x=elem.x+elem.width,y=elem.y+elem.width},
        {x=elem.x,y=elem.y+elem.width}}
    return list
end
