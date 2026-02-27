-- ==========================================
-- 1. CONFIGURATION
-- ==========================================
local terminalIDs = { ["com.mitchellh.ghostty"] = true, ["com.apple.Terminal"] = true }

-- APP SHORTCUTS (Hyper + A + Key)
local sublayerApps = {
  s = "Slack",
  f = "Finder",
  w = "WhatsApp",
  c = "Google Chrome",
  d = "DBeaver",
  l = "Simplenote",
  p = "Postman",
  t = "Todoist",
}

-- YABAI DIRECT SHORTCUTS (Hyper + Key)
local yabaiHyper = {
  l =
  [[/opt/homebrew/bin/yabai -m space --layout "$(/opt/homebrew/bin/yabai -m query --spaces --space | /opt/homebrew/bin/jq -r '.type' | grep -q 'stack' && echo 'bsp' || echo 'stack')"]],
}

-- Internal helpers to convert letters to KeyCodes
local appKeyCodes = {}
for key, name in pairs(sublayerApps) do
  appKeyCodes[hs.keycodes.map[key]] = name
end

local yabaiKeyCodes = {}
for key, cmd in pairs(yabaiHyper) do
  yabaiKeyCodes[hs.keycodes.map[key]] = cmd
end

-- Useful Keycode Reference
local K = {
  a = 0,
  r = 15,
  rightCmd = 54,
  rightCtrl = 62,
  leftCmd = 55,
  leftCtrl = 59
}

-- ==========================================
-- 2. THE MASTER BRAIN
-- ==========================================
local function createTap()
  return hs.eventtap.new({ hs.eventtap.event.types.flagsChanged, hs.eventtap.event.types.keyDown }, function(event)
    local keyCode = event:getKeyCode()
    local flags = event:getFlags()
    local type = event:getType()
    local isKeyDown = (type == hs.eventtap.event.types.keyDown)

    -- A. TRACK RIGHT CMD (Hyper Key)
    if keyCode == K.rightCmd then
      _G.rightCmdDown = flags.cmd
      -- Reset sublayer if Hyper is released
      if not _G.rightCmdDown then _G.sublayerActive = false end
      return false
    end

    -- B. LOGIC FOR HYPER HELD DOWN
    if _G.rightCmdDown and isKeyDown then
      -- 1. PRIORITY: SUBLAYER APP LAUNCHING
      -- This fixes your bug: checking sublayer BEFORE direct yabai commands
      if _G.sublayerActive then
        local targetApp = appKeyCodes[keyCode]
        if targetApp then
          hs.application.launchOrFocus(targetApp)
          _G.sublayerActive = false
          return true -- Consume event
        end
        -- If key pressed wasn't an app, cancel sublayer and continue
        _G.sublayerActive = false
      end

      -- 2. TRIGGER SUBLAYER (Hyper + A)
      if keyCode == K.a then
        _G.sublayerActive = true
        -- hs.alert.show("SUBLAYER ACTIVE", 0.5)
        return true
      end

      -- 3. RELOAD CONFIG (Hyper + R)
      if keyCode == K.r then
        hs.alert.show("Reloading Config...")
        hs.reload()
        return true
      end

      -- 4. YABAI COMMANDS
      local yabaiCmd = yabaiKeyCodes[keyCode]
      if yabaiCmd then
        hs.execute(yabaiCmd)
        return true
      end
    end

    -- C. GHOSTTY TOGGLE (Right Ctrl 62)
    if keyCode == K.rightCtrl and flags.ctrl then
      local gApp = hs.application.get("com.mitchellh.ghostty")
      if gApp and gApp:isFrontmost() then
        gApp:hide()
      else
        hs.application.launchOrFocus("Ghostty")
      end
      return true
    end

    -- D. TERMINAL SWAP
    local app = hs.application.frontmostApplication()
    if app and terminalIDs[app:bundleID()] and not _G.rightCmdDown then
      if keyCode == K.leftCmd then
        event:setFlags({ ctrl = true })
        return false
      elseif keyCode == K.leftCtrl then
        event:setFlags({ cmd = true })
        return false
      elseif isKeyDown then
        if flags.cmd then event:setFlags({ ctrl = true }) end
        if flags.ctrl then event:setFlags({ cmd = true }) end
      end
    end

    return false
  end)
end

-- ==========================================
-- 3. HOUSEKEEPING
-- ==========================================
masterTap = createTap()
masterTap:start()

-- Watchdog to ensure the tap stays alive
hs.timer.doEvery(30, function()
  if not masterTap:isEnabled() then
    masterTap:stop()
    masterTap = createTap()
    masterTap:start()
  end
end)


-- Visual confirmation that the script reached the end
hs.alert.show("Hammerspoon Reloaded 🔄", 1.5)