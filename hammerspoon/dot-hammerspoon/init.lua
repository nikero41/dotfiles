local super = { "cmd", "ctrl", "alt" }
local hyper = { "cmd", "ctrl", "alt", "shift" }

function p(variable) print("🪚 hs.inspect: " .. hs.inspect.inspect(variable)) end

require("lua.initSpoonInstall")

spoon.SpoonInstall:installSpoonFromRepo("EmmyLua")

local myWatcher = hs.pathwatcher
	.new(os.getenv("home") .. "/.hammerspoon/", function(files)
		local doreload = false
		for _, file in pairs(files) do
			if file:sub(-4) == ".lua" then doReload = true end
		end
		if doReload then hs.reload() end
	end)
	:start()
hs.alert.show("Config loaded")
