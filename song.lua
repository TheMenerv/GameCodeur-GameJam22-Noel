---------------------
-- Codé par Menerv --
---------------------



local sngTitle  = love.audio.newSource('musics/title.mp3', 'stream')
local sngGame   = love.audio.newSource('musics/game.mp3', 'stream')
local sngWin    = love.audio.newSource('musics/win.mp3', 'stream')
local sngFail   = love.audio.newSource('musics/fail.mp3', 'stream')



-- PLAY MUSIC
-------------
function PlayMusic(pLabel)

    if pLabel == 'title' then
        sngTitle:setLooping(true)
        sngTitle:setVolume(0.3)
        love.audio.play(sngTitle)
    elseif pLabel == 'game' then
        sngGame:setLooping(true)
        sngGame:setVolume(0.1)
        love.audio.play(sngGame)
    elseif pLabel == 'win' then
        sngWin:setLooping(true)
        sngWin:setVolume(0.3)
        love.audio.play(sngWin)
    elseif pLabel == 'fail' then
        sngFail:setLooping(true)
        sngFail:setVolume(0.3)
        love.audio.play(sngFail)
    end

end



-- STOP MUSCIC
--------------
function StopMusic(pLabel)

    if pLabel == 'title' then
        love.audio.stop(sngTitle)
    elseif pLabel == 'game' then
        love.audio.stop(sngGame)
    elseif pLabel == 'win' then
        love.audio.stop(sngWin)
    elseif pLabel == 'fail' then
        love.audio.stop(sngFail)
    end

end
