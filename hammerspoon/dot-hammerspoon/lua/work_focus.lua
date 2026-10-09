local work_app_name = "Microsoft Teams"

---@param enable boolean
local function set_work_focus(enable)
	if enable then
		hs.shortcuts.run("Start working")
	else
		hs.shortcuts.run("Stop working")
	end
end

local work_app = hs.application.get(work_app_name)
set_work_focus(work_app ~= nil and work_app:isRunning())

local watcher = hs.application.watcher
watcher
	---@param name string|nil
	---@param eventType integer
	.new(function(name, eventType)
		if
			name == work_app_name
			and (eventType == watcher.launched or eventType == watcher.terminated)
		then
			set_work_focus(eventType == watcher.launched)
		end
	end)
	:start()
