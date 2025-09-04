local function moveCursorToScreen(screen)
  if not screen then return end
  local f = screen:frame()
  hs.mouse.setAbsolutePosition({ x = f.x + f.w / 2, y = f.y + f.h / 2 })
end

hs.hotkey.bind({ "cmd" }, "right", function()
  local s = hs.mouse.getCurrentScreen()
  moveCursorToScreen(s and s:next())
end)

hs.hotkey.bind({ "cmd" }, "left", function()
  local s = hs.mouse.getCurrentScreen()
  moveCursorToScreen(s and s:previous())
end)

hs.hotkey.bind({ "cmd" }, "up", function()
  local s = hs.mouse.getCurrentScreen()
  moveCursorToScreen(s and s:toNorth())
end)

hs.hotkey.bind({ "cmd" }, "down", function()
  local s = hs.mouse.getCurrentScreen()
  moveCursorToScreen(s and s:toSouth())
end)

hs.hotkey.bind({ "cmd", "shift" }, "c", function()
  hs.alert.show("Reloaded", 0.4)
  hs.reload()
end)
