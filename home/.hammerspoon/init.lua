-- ## Globals
hs.dockIcon(false)

-- Convience function to relaoad the config, I don't
-- expect this will get used during day to day operation
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "R", function()
  hs.reload()
end)
hs.alert.show("Config loaded")


-- ## Window Management
--
-- Binds commands to move the window to the left and right of the screeen
-- Binds a command to make a window take up the full screen
hs.window.animationDuration = 0

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Left", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Right", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + (max.w / 2)
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "M", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  win:setFrame(max)
end)





-- ## Security
--
-- Bind a keyboard shortcut to lock the screen
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Delete", function()
  hs.caffeinate.lockScreen()
end)



-- ## Note management
--
-- Binds a command to open my note file for the day
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Space", function()
  hs.alert.show("Open Today")
  hs.execute("mate /Users/nicholasrowe/journal/$(date '+journal-%Y-%m-%d.md')")
end)

positions = {
  maximized = hs.layout.maximized,
  centered = {x=0.15, y=0.15, w=0.7, h=0.7},

  left34 = {x=0, y=0, w=0.34, h=1},
  left50 = hs.layout.left50,
  left66 = {x=0, y=0, w=0.66, h=1},

  right34 = {x=0.66, y=0, w=0.34, h=1},
  right50 = hs.layout.right50,
  right66 = {x=0.34, y=0, w=0.66, h=1},

  upper50 = {x=0, y=0, w=1, h=0.5},
  upper50Left50 = {x=0, y=0, w=0.5, h=0.5},
  upper50Right50 = {x=0.5, y=0, w=0.5, h=0.5},

  lower50 = {x=0, y=0.5, w=1, h=0.5},
  lower50Left50 = {x=0, y=0.5, w=0.5, h=0.5},
  lower50Right50 = {x=0.5, y=0.5, w=0.5, h=0.5}
}

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Q", function()
    hs.alert.show("That's all")
	hs.fnutils.each(hs.application.runningApplications(), function(app) print(app:title()) end)
	
	hs.application.find("Safari"):kill()
	hs.application.find("Slack"):kill()
	hs.application.find("TextMate"):kill()
	hs.application.find("Simulator"):kill()
	
	hs.application.find("Xcode"):kill()
	hs.application.find("iTerm"):kill()
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "1", function()
    hs.alert.show("Activating Mode 1")
	hs.application.open("Slack", 2)
	hs.application.open("Safari", 2)
	hs.execute("open https://app.asana.com https://mail.google.com/mail/u/1/\\#inbox")
	hs.application.open("TextMate", 2)
	hs.application.open("Xcode", 2)
	hs.execute("open /Users/nicholasrowe/workspace/everlane/everlane-pocket/everlane-pocket.xcworkspace/")
	hs.application.open("/Users/nicholasrowe/Applications/iTerm.app", 2)

    local laptopScreen = "Color LCD"
    local laptopWindowLayout = {
        {"Safari",  nil, laptopScreen, hs.layout.right50, nil, nil},
        {"TextMate",  nil, laptopScreen, positions.upper50Left50, nil, nil},
        {"Slack",  nil, laptopScreen, positions.lower50Left50, nil, nil},
    }
    hs.layout.apply(laptopWindowLayout)
		
	local secondDisplay = "Thunderbolt Display"
    local secondDisplayLayout = {
        {"Xcode",  nil, secondDisplayLayout, positions.left66, nil, nil},
        {"iTerm",  nil, secondDisplayLayout, {x=0.66, y=0, w=0.5, h=0.5}, nil, nil},
    }
    hs.layout.apply(secondDisplayLayout)	
end)

