---------------------
-- Codé par Menerv --
---------------------



local sequence = {}
local playerSeq = {}



-- GENERATE SEQUENCE
--------------------
function GenerateSequence()

    sequence = {}

    local sled = GetToolIndex('sled')

    sequence[1] = math.floor(math.random(6))
    while sequence[1] == sled do
        sequence[1] = math.floor(math.random(6))
    end
    sequence[2] = math.floor(math.random(6))
    while
            sequence[2] == sled or
            sequence[2] == sequence[1]
        do
        sequence[2] = math.floor(math.random(6))
    end
    sequence[3] = math.floor(math.random(6))
    while
            sequence[3] == sled or
            sequence[3] == sequence[1] or
            sequence[3] == sequence[2]
        do
    sequence[3] = math.floor(math.random(6))
    end
    sequence[4] = math.floor(math.random(6))
    while
            sequence[4] == sled or 
            sequence[4] == sequence[1] or
            sequence[4] == sequence[2] or
            sequence[4] == sequence[3]
        do
    sequence[4] = math.floor(math.random(6))
    end
    sequence[5] = math.floor(math.random(6))
    while
            sequence[5] == sled or
            sequence[5] == sequence[1] or
            sequence[5] == sequence[2] or
            sequence[5] == sequence[3] or
            sequence[5] == sequence[4]
        do
            sequence[5] = math.floor(math.random(6))
    end

end



-- SET PLAYER SEQUENCE
----------------------
function SetPlayerSeq(pSequence)

    if #playerSeq >= 5 then
        ResetPlayerSeq()
    end
    table.insert(playerSeq, pSequence)

end



-- RESET PLAYER SEQUENCE
------------------------
function ResetPlayerSeq()

    for i = #playerSeq, 1, -1 do
        table.remove(playerSeq, i)
    end

end



-- IS VALIDE SEQUENCE
---------------------
function IsValideSeq()

    local match = 0
    for i = 1, #sequence do
        if playerSeq[i] == sequence[i] then
            match = match + 1
        end
    end
    return match == 5

end



-- VALIDATE PLAYER SEQUENCEN
----------------------------
function ValidatePlayerSeq()

    if IsValideSeq() then
        AddGame()
        GenerateSequence()
    end

    ResetPlayerSeq()

end



-- DRAW SEQUENCE
----------------
function DrawSequence()

    for i = 1, #sequence do
        local img = GetToolImg(sequence[i])
        love.graphics.draw(
            img,
            300 + (i * img:getWidth() * (SCALE / 2)) + (10 * i),
            10,
            0,
            SCALE / 2,
            SCALE / 2
        )
    end

end
