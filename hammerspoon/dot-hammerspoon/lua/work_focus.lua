local work_app_name = "Microsoft Teams"

---@param enable boolean
local function set_work_focus(enable)
	if enable then
		hs.shortcuts.run("Start working")
	else
		hs.shortcuts.run("Stop working")
	end
end

if hs.application.get(work_app_name):isRunning() then
	hs.shortcuts.run("Start working")
else
	hs.shortcuts.run("Stop working")
end

hs
	.application
	.watcher
	---@param name string|nil
	---@param eventType integer
	.new(function(name, eventType)
		if
			name == work_app_name
			and (
				eventType == hs.application.watcher.launched
				or eventType == hs.application.watcher.terminated
			)
		then
			set_work_focus(eventType == hs.application.watcher.launched)
		end
	end)
	:start()
