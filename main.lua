---------------------
-- Codé par Menerv --
---------------------

io.stdout:setvbuf('no')
love.graphics.setDefaultFilter("nearest")

local window = {}

SCALE = 2

-- MAP
local BLOC_SIZE = 32
local map = {}
local mouse = {}



-- INITIALISATION
-----------------
function love.load()

    love.window.setMode(768, 640)
    love.window.setTitle("Menerv: Game Codeur GameJam #22")
    local icon = love.image.newImageData('images/icon.png')
    love.window.setIcon(icon)

    window.width = love.graphics.getWidth() / SCALE
    window.height = love.graphics.getHeight() / SCALE

    -- MAP
    map.grid = false
    map.c = {}
    for l = 1, window.height / BLOC_SIZE do
        map[l] = {}
        for c = 1, window.width / BLOC_SIZE do
            map[l][c] = 0
        end
    end

end



-- UPDATE
---------
function love.update(dt)

    -- MAP
    mouse = GetMousePos()

end



-- DRAW
-------
function love.draw()

    -- MAP
    for l = 1, #map do
        for c = 1, #map[l] do
            if map.grid then
                love.graphics.rectangle(
                    'line',
                    (c * BLOC_SIZE * SCALE) - (BLOC_SIZE * SCALE),
                    (l * BLOC_SIZE * SCALE) - (BLOC_SIZE * SCALE),
                    BLOC_SIZE * SCALE,
                    BLOC_SIZE * SCALE
                )
            else
                love.graphics.rectangle(
                    'fill',
                    (c * BLOC_SIZE * SCALE) - (BLOC_SIZE * SCALE),
                    (l * BLOC_SIZE * SCALE) - (BLOC_SIZE * SCALE),
                    BLOC_SIZE * SCALE,
                    BLOC_SIZE * SCALE
                )
            end
        end
    end
    love.graphics.setColor(1, 0, 0)
    love.graphics.print("L="..tostring(mouse.l).." C="..tostring(mouse.c), 5, 5)
    love.graphics.setColor(1, 1, 1)

end



-- KEYBOARD
-----------
function love.keypressed(key)

    print(key)

    -- MAP
    if key == 'g' then
        if map.grid then
            map.grid = false
        else
            map.grid = true
        end
    end

end



-- GET MOUSE POS
----------------
function GetMousePos()

    local x, y = love.mouse.getPosition()

    local myMouse = {}

    myMouse.l = math.floor(y / (BLOC_SIZE * SCALE)) + 1
    myMouse.c = math.floor(x / (BLOC_SIZE * SCALE)) + 1

    return myMouse

end
