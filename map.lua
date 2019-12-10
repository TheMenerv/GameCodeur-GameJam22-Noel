---------------------
-- Codé par Menerv --
---------------------



BLOC_SIZE = 32

Map = {}



-- MAP LOAD
-----------
function MapLoad()

  Map.grid = false
    Map.c = {}
    for l = 1, Window.height / BLOC_SIZE do
        Map[l] = {}
        for c = 1, Window.width / BLOC_SIZE do
            Map[l][c] = 0
        end
    end

end



-- MAP DRAW
-----------
function MapDraw()

    for l = 1, #Map do
        for c = 1, #Map[l] do
            if Map.grid then
                love.graphics.rectangle(
                    'line',
                    (c * BLOC_SIZE * SCALE) - (BLOC_SIZE * SCALE),
                    (l * BLOC_SIZE * SCALE) - (BLOC_SIZE * SCALE),
                    BLOC_SIZE * SCALE,
                    BLOC_SIZE * SCALE
                )
            else
                love.graphics.rectangle(
                    'fill',
                    (c * BLOC_SIZE * SCALE) - (BLOC_SIZE * SCALE),
                    (l * BLOC_SIZE * SCALE) - (BLOC_SIZE * SCALE),
                    BLOC_SIZE * SCALE,
                    BLOC_SIZE * SCALE
                )
            end
        end
    end

end
