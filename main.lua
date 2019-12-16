---------------------
-- Codé par Menerv --
---------------------

io.stdout:setvbuf('no')
love.graphics.setDefaultFilter("nearest")
math.randomseed(os.time())



require('utils')
require('screens')
require('map')
require('gui')
require('santa')
require('game')
require('song')



Window = {}
Mouse = {}

SCALE = 4

DebugMode = false

TimeOver = false
GameWin = false

local screen, tempScreen

local flashTime = 0
local flashAlpha = 0



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
    tempScreen = 'none'
    InitGame()

end



-- UPDATE
---------
function love.update(dt)

    -- MUSIC
    if screen ~= tempScreen then
        if tempScreen ~= 'none' then
            StopMusic(tempScreen)
        end
        PlayMusic(screen)
        tempScreen = screen
    end

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

    if flashTime > 0 then
        flashTime = flashTime - (dt * 60)
        flashAlpha = 1
    else
        flashTime = 0
        if flashAlpha > 0 then
            flashAlpha = flashAlpha - (dt * 10)
        else
            flashAlpha = 0
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
        --if DebugMode then
        --    MapDebugDraw()
        --    love.graphics.setColor(1, 0, 0)
        --    love.graphics.print(
        --        "L="..tostring(Mouse.l)..
        --        " C="..tostring(Mouse.c)..
        --        " B="..tostring(GetMapContent(Mouse.l, Mouse.c))..
        --        " T="..tostring(GetMapTool(Mouse.l, Mouse.c)),
        --        5, 5
        --    )
        --    love.graphics.setColor(1, 1, 1)
        --else
            -- MAP
            MapDraw()
            -- GUI
            GUIDraw()
            -- SANTA
            SantaDraw()
            -- GAME SEQUENCE
            DrawSequence()
            -- FLASH
            FlashDraw()
        --end
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
    --if key == 'd' and screen == 'game' then
    --    DebugMode = not DebugMode
    --end

    -- GENERATE NEW SEQUENCE
    --if key == 'g' and screen == 'game' then
    --    GenerateSequence()
    --end

    -- GAME SEQUENCE
    if key == 'c' and screen == 'game' then
        
        local tool = GetNearTool()
        local sled = GetToolIndex('sled')

        if tool == sled then -- Validation de la séquence du joueur
            ValidatePlayerSeq()
            Flash()
        elseif tool ~= 0 then -- Ajout de l'outil à la séquence du joueur
            SetPlayerSeq(tool)
            Flash()
        end

    end

end



-- INIT GAME
------------
function InitGame()

    DebugMode = false
    TimeOver = false
    GameWin = false
    
    -- SCREEN TITLE
    screen = 'title'

    -- MAP
    MapLoad()

    -- GUI
    GUILoad()

    -- GAME
    GenerateSequence()
    ResetPlayerSeq()

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
    MapReload()

    -- GUI
    GUILoad()

    -- GAME
    GenerateSequence()
    ResetPlayerSeq()
    NewGame()

    -- SANTA
    SantaLoad()

end



-- FLASH
--------
function Flash()

    flashTime = 1

end



-- FLASH DRAW
-------------
function FlashDraw()

    love.graphics.setColor(1, 1, 1, flashAlpha)
    love.graphics.rectangle('fill', 0, 0, Window.width * SCALE, Window.height * SCALE)
    love.graphics.setColor(1, 1, 1, 1)

end
