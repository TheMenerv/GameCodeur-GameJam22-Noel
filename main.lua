---------------------
-- Codé par Menerv --
---------------------

io.stdout:setvbuf('no')
love.graphics.setDefaultFilter("nearest")



require('utils')
require('map')



Window = {}
Mouse = {}

SCALE = 2



-- INITIALISATION
-----------------
function love.load()

    love.window.setMode(768, 640)
    love.window.setTitle("Menerv: Game Codeur GameJam #22")
    local icon = love.image.newImageData('images/icon.png')
    love.window.setIcon(icon)

    Window.width = love.graphics.getWidth() / SCALE
    Window.height = love.graphics.getHeight() / SCALE

    -- MAP
    MapLoad()

end



-- UPDATE
---------
function love.update(dt)

    Mouse = GetMousePos()

end



-- DRAW
-------
function love.draw()

    -- MAP
    MapDraw()

    -- DEBUG
    love.graphics.setColor(1, 0, 0)
    love.graphics.print("L="..tostring(Mouse.l).." C="..tostring(Mouse.c), 5, 5)
    love.graphics.setColor(1, 1, 1)

end



-- KEYBOARD
-----------
function love.keypressed(key)

    print(key)

    -- MAP SWITCH
    if key == 'g' then
        if Map.grid then
            Map.grid = false
        else
            Map.grid = true
        end
    end

end
