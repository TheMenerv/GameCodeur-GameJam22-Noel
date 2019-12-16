---------------------
-- Codé par Menerv --
---------------------



BLOC_SIZE = 16

TILE_GROUND     = 'ground'
TILE_WALL       = 'wall'
TILE_DOOR_FACE  = 'door face'
TILE_DOOR_SIDE  = 'door side'

Map = {}
Map.listTools = {}

local imgGround     = love.graphics.newImage('images/ground.png')
local imgWall       = love.graphics.newImage('images/wall.png')
local imgDoorSide   = love.graphics.newImage('images/door1.png')
local imgDoorFace   = love.graphics.newImage('images/door2.png')
local imgAnvil      = love.graphics.newImage('images/anvil.png')
local imgBench      = love.graphics.newImage('images/bench.png')
local imgPress      = love.graphics.newImage('images/press.png')
local imgSaw        = love.graphics.newImage('images/saw.png')
local imgSled       = love.graphics.newImage('images/sled.png')
local imgSmithy     = love.graphics.newImage('images/smithy.png')



-- MAP RELOAD
-------------
function MapReload()

    DebugMode = false

    -- Création du batiment
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



-- MAP LOAD
-----------
function MapLoad()

    MapReload()

    -- Création des outillages
    CreateTool('anvil', 6, 3, imgAnvil)
    CreateTool('bench', 4, 5, imgBench)
    CreateTool('press', 8, 5, imgPress)
    CreateTool('saw', 4, 7, imgSaw)
    CreateTool('sled', 6, 10, imgSled)
    CreateTool('smithy', 8, 7, imgSmithy)

end



-- MAP DRAW
-----------
function MapDebugDraw()

    for l = 1, #Map do
        for c = 1, #Map[l] do
            love.graphics.rectangle(
                'line',
                (c * BLOC_SIZE * SCALE) - (BLOC_SIZE * SCALE),
                (l * BLOC_SIZE * SCALE) - (BLOC_SIZE * SCALE),
                BLOC_SIZE * SCALE,
                BLOC_SIZE * SCALE
            )
        end
    end

end



-- MAP DRAW
-----------
function MapDraw()

    -- Déssine le batiment
    for l = 1, #Map do
        for c = 1, #Map[l] do
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

    -- Déssine les outils
    for t = #Map.listTools, 1, -1 do
        local tool = Map.listTools[t]
        love.graphics.draw(tool.img, tool.x, tool.y, 0, SCALE, SCALE)
    end

end



-- GET MAP CONTENT
------------------
function GetMapContent(pL, pC)

    return Map[pL][pC]

end



-- PIXEL TO MAP
------------------------
function PixelToMap(pX, pY)

    local coor = {}
    coor.l = math.floor(pY / (BLOC_SIZE * SCALE)) + 1
    coor.c = math.floor(pX / (BLOC_SIZE * SCALE)) + 1

    return coor

end



-- GET MAP TOOL
------------------
function GetMapTool(pL, pC)

    for t = #Map.listTools, 1, -1 do
        local tool = Map.listTools[t]
        if pL == tool.l and pC == tool.c then
            return tool.name
        end
    end

    return 'empty'

end



-- LOCAL : CREATE TOOL
----------------------
function CreateTool(pName, pL, pC, pTile)

    local myTool = {}
    myTool.name = pName
    myTool.l = pL
    myTool.c = pC
    myTool.x = (pC * (BLOC_SIZE * SCALE)) - (BLOC_SIZE * SCALE)
    myTool.y = (pL * (BLOC_SIZE * SCALE)) - (BLOC_SIZE * SCALE)
    myTool.img = pTile

    table.insert(Map.listTools, myTool)

    return myTool

end



-- GET TOOL INFO
----------------
function GetToolInfo(pToolName)

    for i = #Map.listTools, 1, -1 do
        local tool = Map.listTools[i]
        if tool.name == pToolName then
            return tool.currentLevel
        end
    end

    return 0

end



-- GET TOOL IMG
---------------
function GetToolImg(pToolIndex)

    return Map.listTools[pToolIndex].img

end



-- GET TOOL INDEX
-----------------
function GetToolIndex(pToolName)

    for i = #Map.listTools, 1, -1 do
        local tool = Map.listTools[i]
        if tool.name == pToolName then
            return i
        end
    end

end
