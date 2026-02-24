-- ==========================================
-- 1. CONFIGURATION
-- ==========================================
local terminalIDs = { ["com.mitchellh.ghostty"] = true, ["com.apple.Terminal"] = true }

-- JUST ADD NEW APPS HERE (Key = Letter, Value = App Name)
local sublayerApps = {
  s = "Slack",
  f = "Finder",
  w = "WhatsApp",
  c = "Google Chrome",
  d = "Discord",
  l = "Simplenote",   -- Just added!
  p = "Postman",
  t = "Todoist"
}

-- Internal helper to convert letters to KeyCodes automatically
local appKeyCodes = {}
for key, name in pairs(sublayerApps) do
  appKeyCodes[hs.keycodes.map[key]] = name
end

-- ==========================================
-- 2. THE MASTER BRAIN
-- ==========================================
local function createTap()
  return hs.eventtap.new({ hs.eventtap.event.types.flagsChanged, hs.eventtap.event.types.keyDown }, function(event)
    local keyCode = event:getKeyCode()
    local flags = event:getFlags()
    local type = event:getType()
    local isKeyDown = (type == hs.eventtap.event.types.keyDown)

    -- A. TRACK RIGHT CMD (54) -> CONVERT TO HYPER
    if keyCode == 54 then
      _G.rightCmdDown = flags.cmd
      if _G.rightCmdDown then
        event:setFlags({ cmd = true, ctrl = true, alt = true, shift = true })
      end
      return false
    end

    -- B. HYPER + A (Trigger Sublayer)
    -- KeyCode 0 is 'a'
    if keyCode == 0 and isKeyDown and _G.rightCmdDown then
      _G.sublayerActive = true
      -- hs.alert.show("SUBLAYER ACTIVE", 0.5)
      return true
    end

    -- C. SUBLAYER APP LAUNCHING
    if _G.sublayerActive and isKeyDown then
      local targetApp = appKeyCodes[keyCode]
      if targetApp then
        hs.application.launchOrFocus(targetApp)
        _G.sublayerActive = false
        return true                   -- Kill the key press
      end
      _G.sublayerActive = false       -- Exit if a non-mapped key is pressed
    end

    -- D. GHOSTTY TOGGLE (Right Ctrl 62)
    if keyCode == 62 and flags.ctrl then
      local gApp = hs.application.get("com.mitchellh.ghostty")
      if gApp and gApp:isFrontmost() then gApp:hide() else hs.application.launchOrFocus("Ghostty") end
      return true
    end

    -- E. TERMINAL SWAP
    local app = hs.application.frontmostApplication()
    if app and terminalIDs[app:bundleID()] and not _G.rightCmdDown then
      if keyCode == 55 then
        event:setFlags({ ctrl = true })
        return false
      elseif keyCode == 59 then
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
-- 3. HOUSEKEEPING (Watchdog & Reload)
-- ==========================================
masterTap = createTap()
masterTap:start()

hs.timer.doEvery(30, function()
  if not masterTap:isEnabled() then
    masterTap:stop()
    masterTap = createTap()
    masterTap:start()
  end
end)

hs.hotkey.bind({}, "capslock", function() hs.eventtap.keyStroke({ "cmd" }, "`") end)

hs.alert.show("SYSTEMS READY 🚀")