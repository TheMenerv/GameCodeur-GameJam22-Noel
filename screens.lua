---------------------
-- Codé par Menerv --
---------------------



local imgScreenTitle    = love.graphics.newImage('images/screenTitle.jpg')
local imgScreenWin      = love.graphics.newImage('images/screenWin.jpg')
local imgScreenFail     = love.graphics.newImage('images/screenFail.jpg')



-- DRAW TITLE SCREEN
--------------------
function DrawTitleScreen()

    love.graphics.draw(imgScreenTitle, 0, 0)

end



-- DRAW WIN SCREEN
------------------
function DrawWinScreen()

    love.graphics.draw(imgScreenWin, 0, 0)

end



-- DRAW FAIL SCREEN
-------------------
function DrawFailScreen()

    love.graphics.draw(imgScreenFail, 0, 0)

end
