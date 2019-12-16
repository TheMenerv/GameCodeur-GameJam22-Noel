---------------------
-- Codé par Menerv --
---------------------



local games, maxGames, timerDay
maxGames = 1



-- LOAD GUI
-----------
function GUILoad()

    games = 0
    timerDay = 365

end



-- UPDATE GUI
-------------
function GUIUpdate(dt)

    if games >= maxGames then
        TimeOver = true
        GameWin = true
    end

    timerDay = timerDay - (dt * 2)
    if timerDay < 0 then
        timerDay = 0
        TimeOver = true
    end

end



-- DRAW GUI
-----------
function GUIDraw()

    love.graphics.print("Jours avant Noel: "..tostring(math.floor(timerDay)), 5, 5)
    love.graphics.print("Jouets produits: "..tostring(math.floor(games)).."/"..tostring(maxGames), 5, 20)

end



-- ADD GAME
-----------
function AddGame()

    games = games + 1

end



-- NEW GAME
-----------
function NewGame()

    if maxGames == 1 then
        maxGames = 10
    else
        maxGames = maxGames + 1
    end

end
