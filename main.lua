---------------------
-- Codé par Menerv --
---------------------

io.stdout:setvbuf('no')
love.graphics.setDefaultFilter("nearest")



require('utils')
require('screens')
require('map')
require('gui')
require('santa')



Window = {}
Mouse = {}

SCALE = 4

DebugMode = false

TimeOver = false
GameWin = false

local screen



-- INITIALISATION
-----------------
function love.load()

    love.window.setMode(768, 640)
    love.window.setTitle("Menerv: Game Codeur GameJam #22")
    local icon = love.image.newImageData('images/icon.png')
    love.window.setIcon(icon)

    Window.width = love.graphics.getWidth() / SCALE
    Window.height = love.graphics.getHeight() / SCALE

    -- INIT GAME
    InitGame()

end



-- UPDATE
---------
function love.update(dt)

    Mouse = GetMousePos()

    if screen == 'game' then
        if TimeOver then
            if GameWin then
                screen = 'win'
            else
                screen = 'fail'
            end
        -- GAME UPDATE
        else
            -- GUI
            GUIUpdate(dt)
            -- SANTA
            SantaUpdate(dt)
        end
    end


end



-- DRAW
-------
function love.draw()

    -- TITLE SCREEN
    if screen == 'title' then
        DrawTitleScreen()
    
    -- WIN SCREEN
    elseif screen == 'win' then
        DrawWinScreen()

    -- FAIL SCREEN
    elseif screen == 'fail' then
        DrawFailScreen()

    -- GAME SCREEN
    else
        -- DEBUG
        if DebugMode then
            MapDebugDraw()
            love.graphics.setColor(1, 0, 0)
            love.graphics.print(
                "L="..tostring(Mouse.l)..
                " C="..tostring(Mouse.c)..
                " B="..tostring(GetMapContent(Mouse.l, Mouse.c))..
                " T="..tostring(GetMapTool(Mouse.l, Mouse.c)),
                5, 5
            )
            love.graphics.setColor(1, 1, 1)
        else
            -- MAP
            MapDraw()
            -- GUI
            GUIDraw()
            -- SANTA
            SantaDraw()
        end
    end

end



-- KEYBOARD
-----------
function love.keypressed(key)

    print(key)

    -- QUIT
    if key == 'escape' then
        love.event.quit()
    end

    -- SCREEN CHANGE
    if key == 'space' then
        if screen == 'title' then
            screen = 'game'
        elseif screen == 'win' then
            screen = 'title'
            ResetGame()
        elseif screen == 'fail' then
            screen = 'title'
            ResetGame()
        end
    end

    -- DEBUG MODE SWITCH
    if key == 'd' and screen == 'game' then
        DebugMode = not DebugMode
    end

end



-- INIT GAME
------------
function InitGame()

    ResetGame()

    -- SANTA
    SantaLoad()

end



-- RESET GAME
------------
function ResetGame()

    DebugMode = false
    TimeOver = false
    GameWin = false
    
    -- SCREEN TITLE
    screen = 'title'

    -- MAP
    MapLoad()

    -- GUI
    GUILoad()

end
