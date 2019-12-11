---------------------
-- Codé par Menerv --
---------------------



local bench, games, timerDay



-- LOAD GUI
-----------
function GUILoad()

    bench = 1
    games = 0
    timerDay = 365

end



-- UPDATE GUI
-------------
function GUIUpdate(dt)

    timerDay = timerDay - dt
    if timerDay < 0 then timerDay = 0 end

    bench = GetToolInfo('bench')

end



-- DRAW GUI
-----------
function GUIDraw()

    love.graphics.print("Jours avant Noel: "..tostring(math.floor(timerDay)), 5, 5)
    love.graphics.print("Jouets produits: "..tostring(math.floor(games)).."/10000", 5, 20)
    love.graphics.print("Niveau de l'établi: "..tostring(bench).."/4", 200, 5)

end
