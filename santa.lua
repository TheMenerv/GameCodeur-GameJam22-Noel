---------------------
-- Codé par Menerv --
---------------------



local santa = {}
santa.img = love.graphics.newImage('images/santa.png')

local cKey = love.graphics.newImage('images/c.png')

local collideTool = false
local tool = 0

local speed = 3



-- LOAD SANTA
-------------
function SantaLoad()

    santa.dir = 'right'
    santa.x = ((Window.width / 2) - (santa.img:getWidth() / 2)) * SCALE
    santa.y = (Window.height / 2) * SCALE

end



-- UPDATE SANTA
---------------
function SantaUpdate(dt)

    -- Sauvegarde de la position initial
    local temp = {}
    temp.x = santa.x
    temp.y = santa.y

    -- Déplacements
    if love.keyboard.isDown('up') then
        santa.y = santa.y - speed * 60 * dt
    end
    if love.keyboard.isDown('right') then
        santa.dir = 'right'
        santa.x = santa.x + speed * 60 * dt
    end
    if love.keyboard.isDown('down') then
        santa.y = santa.y + speed * 60 * dt
    end
    if love.keyboard.isDown('left') then
        santa.dir = 'left'
        santa.x = santa.x - speed * 60 * dt
    end

    -- Collision
    if SantaIsCollide() then
        santa.x = temp.x
        santa.y = temp.y
    end

    -- En contact avec un outil
    local t = SantaIsToolCollide()
    if t ~= 'none' then
        collideTool = true
        tool = GetToolIndex(t)
    else
        collideTool = false
        tool = 0
    end

end



-- DRAW SANTA
-------------
function SantaDraw()

    if santa.dir == 'left' then
        love.graphics.draw(santa.img, santa.x, santa.y, 0, SCALE, SCALE)
    else
        love.graphics.draw(santa.img, santa.x + (santa.img:getWidth() * SCALE), santa.y, 0, - SCALE, SCALE)
    end
    -- Debug collision
    --local x1 = santa.x + (3 * SCALE)
    --local x2 = santa.x + (santa.img:getWidth() * SCALE) - (3 * SCALE)
    --local y1 = santa.y + (santa.img:getHeight() * SCALE) - (2 * SCALE)
    --local y2 = santa.y + (santa.img:getHeight() * SCALE)
    --love.graphics.rectangle('line', x1, y1, x2-x1, y2-y1)

    if collideTool then
        love.graphics.draw(
            cKey,
            santa.x + (santa.img:getWidth()/2) * SCALE - cKey:getWidth()/2,
            santa.y + (santa.img:getHeight()) * SCALE + 5
        )
    end

end



-- IS COLLIDE
-------------
function SantaIsCollide()

    local x1 = santa.x + (3 * SCALE)
    local x2 = santa.x + (santa.img:getWidth() * SCALE) - (3 * SCALE)
    local y1 = santa.y + (santa.img:getHeight() * SCALE) - (2 * SCALE)
    local y2 = santa.y + (santa.img:getHeight() * SCALE)

    local s1 = {}
    local s2 = {}
    local s3 = {}
    local s4 = {}

    s1 = PixelToMap(x1, y1)
    s2 = PixelToMap(x1, y2)
    s3 = PixelToMap(x2, y1)
    s4 = PixelToMap(x2, y2)

    local c1 = GetMapContent(s1.l, s1.c)
    local c2 = GetMapContent(s2.l, s2.c)
    local c3 = GetMapContent(s3.l, s3.c)
    local c4 = GetMapContent(s4.l, s4.c)

    local c5 = GetMapTool(s1.l, s1.c)
    local c6 = GetMapTool(s2.l, s2.c)
    local c7 = GetMapTool(s3.l, s3.c)
    local c8 = GetMapTool(s4.l, s4.c)

    if
        c1 == TILE_WALL or c1 == TILE_DOOR_FACE or c1 == TILE_DOOR_SIDE or
        c2 == TILE_WALL or c2 == TILE_DOOR_FACE or c2 == TILE_DOOR_SIDE or
        c3 == TILE_WALL or c3 == TILE_DOOR_FACE or c3 == TILE_DOOR_SIDE or
        c4 == TILE_WALL or c4 == TILE_DOOR_FACE or c4 == TILE_DOOR_SIDE or
        c5 ~= 'empty' or c6 ~= 'empty' or c7 ~= 'empty' or c8 ~= 'empty'
    then
        return true
    else
        return false
    end

end



-- IS TOOL COLLIDE
------------------
function SantaIsToolCollide()

    local x1 = santa.x + (3 * SCALE) - 5
    local x2 = santa.x + (santa.img:getWidth() * SCALE) - (3 * SCALE) + 5
    local y1 = santa.y + (santa.img:getHeight() * SCALE) - (2 * SCALE) - 5
    local y2 = santa.y + (santa.img:getHeight() * SCALE) + 5

    local s1 = {}
    local s2 = {}
    local s3 = {}
    local s4 = {}

    s1 = PixelToMap(x1, y1)
    s2 = PixelToMap(x1, y2)
    s3 = PixelToMap(x2, y1)
    s4 = PixelToMap(x2, y2)

    local c5 = GetMapTool(s1.l, s1.c)
    local c6 = GetMapTool(s2.l, s2.c)
    local c7 = GetMapTool(s3.l, s3.c)
    local c8 = GetMapTool(s4.l, s4.c)

    if
        c5 ~= 'empty'
    then
        return c5
    elseif c6 ~= 'empty' then
        return c6
    elseif c7 ~= 'empty' then
        return c7
    elseif c8 ~= 'empty' then
        return c8
    else
        return 'none'
    end

end



-- GET NEAR TOOL
----------------
function GetNearTool()

    return tool

end
