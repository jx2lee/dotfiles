-- ~/.hammerspoon/init.lua

-- 여러 앱에서 동작하도록 set 형태로 관리 (필요하면 vscode/windsurf 등 추가)
local targetApps = {
  ["com.mitchellh.ghostty"] = true,
  ["com.microsoft.VSCode"] = true,
  -- ["com.exafunction.windsurf"] = true,
}

-- 시스템 설정 > 키보드 > 입력 소스에 따라 "com.apple.keylayout.US" 일 수도 있음
local englishSource = "com.apple.keylayout.ABC"

local function switchToEnglish()
  if hs.keycodes.currentSourceID() ~= englishSource then
    hs.keycodes.currentSourceID(englishSource)
  end
end

if escape_keyevent then escape_keyevent:stop() end

escape_keyevent = hs.eventtap.new({ hs.eventtap.event.types.keyDown }, function(event)
  local app = hs.application.frontmostApplication()
  if not (app and targetApps[app:bundleID()]) then return false end

  local keycode = hs.keycodes.map[event:getKeyCode()]
  local flags = event:getFlags()

  -- ESC: 키는 그대로 통과시키고, 약간 뒤에 영문으로 전환
  if keycode == "escape" then
    hs.timer.doAfter(0.03, switchToEnglish)
    return false
  end

  -- Ctrl+C: 영문으로 전환만 하고 키는 그대로 통과
  -- (터미널에서는 Ctrl+C가 SIGINT라 막으면 안 됨)
  if keycode == "c" and flags.ctrl and not flags.cmd and not flags.alt then
    switchToEnglish()
    return false
  end

  -- Ctrl+[ 도 vim에서 ESC와 같으므로 함께 처리
  if keycode == "[" and flags.ctrl then
    hs.timer.doAfter(0.03, switchToEnglish)
    return false
  end

  return false
end)

escape_keyevent:start()
hs.alert.show("Hammerspoon: 한영 자동전환 로드됨")