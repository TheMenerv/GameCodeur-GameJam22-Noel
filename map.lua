---------------------
-- Codé par Menerv --
---------------------



BLOC_SIZE = 16

TILE_GROUND     = 'ground'
TILE_WALL       = 'wall'
TILE_DOOR_FACE  = 'door face'
TILE_DOOR_SIDE  = 'door side'

Map = {}

local imgGround     = love.graphics.newImage('images/ground.png')
local imgWall       = love.graphics.newImage('images/wall.png')
local imgDoorSide   = love.graphics.newImage('images/door1.png')
local imgDoorFace   = love.graphics.newImage('images/door2.png')


-- MAP LOAD
-----------
function MapLoad()

    DebugMode = false
    Map.c = {}
    for l = 1, Window.height / BLOC_SIZE do
        Map[l] = {}
        for c = 1, Window.width / BLOC_SIZE do
            if (l == 2 and c == math.abs(Window.width / BLOC_SIZE / 2)) or
                    (l == Window.height / BLOC_SIZE and c == math.abs(Window.width / BLOC_SIZE / 2)) then
                Map[l][c] = TILE_DOOR_FACE
            elseif (l == math.abs(Window.height / BLOC_SIZE / 2) + 1 and c == 1) or
                    (l == math.abs(Window.height / BLOC_SIZE / 2) + 1 and c == Window.width / BLOC_SIZE) then
                Map[l][c] = TILE_DOOR_SIDE
            elseif l ==2 or l == Window.height / BLOC_SIZE or (c == 1 and l ~= 1) or (c == Window.width / BLOC_SIZE and l ~= 1) then
                Map[l][c] = TILE_WALL
            elseif l ~= 1 then
                Map[l][c] = TILE_GROUND
            end
        end
    end

end



-- MAP DRAW
-----------
function MapDraw()

    for l = 1, #Map do
        for c = 1, #Map[l] do
            if DebugMode then
                love.graphics.rectangle(
                    'line',
                    (c * BLOC_SIZE * SCALE) - (BLOC_SIZE * SCALE),
                    (l * BLOC_SIZE * SCALE) - (BLOC_SIZE * SCALE),
                    BLOC_SIZE * SCALE,
                    BLOC_SIZE * SCALE
                )
            else
                if Map[l][c] == TILE_GROUND then
                    love.graphics.draw(
                        imgGround,
                        (c * BLOC_SIZE * SCALE) - (BLOC_SIZE * SCALE),
                        (l * BLOC_SIZE * SCALE) - (BLOC_SIZE * SCALE),
                        0, SCALE, SCALE
                    )
                elseif Map[l][c] == TILE_WALL then
                    love.graphics.draw(
                        imgWall,
                        (c * BLOC_SIZE * SCALE) - (BLOC_SIZE * SCALE),
                        (l * BLOC_SIZE * SCALE) - (BLOC_SIZE * SCALE),
                        0, SCALE, SCALE
                    )
                elseif Map[l][c] == TILE_DOOR_SIDE then
                    love.graphics.draw(
                        imgDoorSide,
                        (c * BLOC_SIZE * SCALE) - (BLOC_SIZE * SCALE),
                        (l * BLOC_SIZE * SCALE) - (BLOC_SIZE * SCALE),
                        0, SCALE, SCALE
                    )
                elseif Map[l][c] == TILE_DOOR_FACE then
                    love.graphics.draw(
                        imgDoorFace,
                        (c * BLOC_SIZE * SCALE) - (BLOC_SIZE * SCALE),
                        (l * BLOC_SIZE * SCALE) - (BLOC_SIZE * SCALE),
                        0, SCALE, SCALE
                    )
                end
            end
        end
    end

end



-- GET MAP CONTENT
------------------
function GetMapContent(pL, pC)

    return Map[pL][pC]

end
