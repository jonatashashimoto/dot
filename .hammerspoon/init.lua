-- ==========================================
-- 1. CONFIGURATION
-- ==========================================
local terminalIDs = { ["com.mitchellh.ghostty"] = true, ["com.apple.Terminal"] = true }

-- APP SHORTCUTS (Hyper + A + Key)
local sublayerApps = {
  s = "Slack", f = "Finder", w = "WhatsApp",
  c = "Google Chrome", d = "Discord", l = "Simplenote",
  p = "Postman", t = "Todoist"
}

-- YABAI DIRECT SHORTCUTS (Hyper + Key)
local yabaiHyper = {
  -- Added /opt/homebrew/bin/ to the path to ensure it finds yabai and jq
  l = [[/opt/homebrew/bin/yabai -m space --layout "$(/opt/homebrew/bin/yabai -m query --spaces --space | /opt/homebrew/bin/jq -r '.type' | grep -q 'stack' && echo 'bsp' || echo 'stack')"]]
}

-- Internal helpers
local appKeyCodes = {}
for key, name in pairs(sublayerApps) do appKeyCodes[hs.keycodes.map[key]] = name end

local yabaiKeyCodes = {}
for key, cmd in pairs(yabaiHyper) do yabaiKeyCodes[hs.keycodes.map[key]] = cmd end

-- ==========================================
-- 2. THE MASTER BRAIN
-- ==========================================
local function createTap()
  return hs.eventtap.new({ hs.eventtap.event.types.flagsChanged, hs.eventtap.event.types.keyDown }, function(event)
    local keyCode = event:getKeyCode()
    local flags = event:getFlags()
    local type = event:getType()
    local isKeyDown = (type == hs.eventtap.event.types.keyDown)

    -- A. TRACK RIGHT CMD (54) -> HYPER
    if keyCode == 54 then
      _G.rightCmdDown = flags.cmd
      if _G.rightCmdDown then
        event:setFlags({ cmd = true, ctrl = true, alt = true, shift = true })
      end
      return false
    end

    -- B. HYPER COMMANDS
    if _G.rightCmdDown and isKeyDown then
        -- 1. HYPER + A (Trigger Sublayer)
        if keyCode == 0 then
            _G.sublayerActive = true
            -- hs.alert.show("SUBLAYER ACTIVE", 0.5)
            return true
        end

        -- 2. HYPER + L (Layout Toggle)
        -- Hardcoded check for KeyCode 37 (standard 'l') as a fallback
        if keyCode == hs.keycodes.map["l"] or keyCode == 37 then
            print("Hyper+L Triggered") -- Check Hammerspoon Console to see this
            hs.execute(yabaiHyper.l)
            return true
        end
    end

    -- C. SUBLAYER APP LAUNCHING
    if _G.sublayerActive and isKeyDown then
      local targetApp = appKeyCodes[keyCode]
      if targetApp then
        hs.application.launchOrFocus(targetApp)
        _G.sublayerActive = false
        return true
      end
      _G.sublayerActive = false
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
      if keyCode == 55 then event:setFlags({ ctrl = true }) return false
      elseif keyCode == 59 then event:setFlags({ cmd = true }) return false
      elseif isKeyDown then
        if flags.cmd then event:setFlags({ ctrl = true }) end
        if flags.ctrl then event:setFlags({ cmd = true }) end
      end
    end

    return false
  end)
end

masterTap = createTap():start()
hs.timer.doEvery(30, function() if not masterTap:isEnabled() then masterTap:stop(); masterTap = createTap():start() end end)
hs.hotkey.bind({}, "capslock", function() hs.eventtap.keyStroke({ "cmd" }, "`") end)
hs.alert.show("SYSTEMS READY 🚀")