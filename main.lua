---------------------
-- Codé par Menerv --
---------------------

io.stdout:setvbuf('no')
love.graphics.setDefaultFilter("nearest")

local window = {}

-- MAP
local BLOC_SIZE = 32
local map = {}
local mouse = {}



-- INITIALISATION
-----------------
function love.load()

    window.width = love.graphics.getWidth()
    window.height = love.graphics.getHeight()

    -- MAP
    map.grid = false
    local l, c
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
    local l, c
    for l = 1, #map do
        for c = 1, #map[l] do
            if map.grid then
                love.graphics.rectangle(
                    'line',
                    (c * BLOC_SIZE) - BLOC_SIZE,
                    (l * BLOC_SIZE) - BLOC_SIZE,
                    BLOC_SIZE,
                    BLOC_SIZE
                )
            else
                love.graphics.rectangle(
                    'fill',
                    (c * BLOC_SIZE) - BLOC_SIZE,
                    (l * BLOC_SIZE) - BLOC_SIZE,
                    BLOC_SIZE,
                    BLOC_SIZE
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

    myMouse.l = math.floor(y / BLOC_SIZE) + 1
    myMouse.c = math.floor(x / BLOC_SIZE) + 1

    return myMouse

end
