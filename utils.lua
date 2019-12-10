---------------------
-- Codé par Menerv --
---------------------



-- GET MOUSE POS
----------------
function GetMousePos(pBlocSize)

  local x, y = love.mouse.getPosition()

  local myMouse = {}

  myMouse.l = math.floor(y / (BLOC_SIZE * SCALE)) + 1
  myMouse.c = math.floor(x / (BLOC_SIZE * SCALE)) + 1

  return myMouse

end
