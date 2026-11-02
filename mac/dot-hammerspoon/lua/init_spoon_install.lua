local function bootstrapSpoonInstall()
	local tempfile = hs.configdir .. "/spoon.zip"
	local _, success = hs.execute(
		string.format(
			"/usr/bin/curl -sSL -o %s https://github.com/Hammerspoon/Spoons/raw/master/Spoons/SpoonInstall.spoon.zip",
			tempfile
		)
	)

	if not success then
		hs.notify.show("Hammerspoon", "Bootstrap", "Failed to download SpoonInstall")
		return
	end

	local _, unzipSuccess = hs.execute(
		string.format(
			"/usr/bin/unzip -o %s -d %s 2>&1 && rm %s",
			tempfile,
			hs.configdir .. "/Spoons",
			tempfile
		)
	)

	if not unzipSuccess then
		hs.notify.show("Hammerspoon", "Bootstrap", "Failed to uncompress SpoonInstall")
		return
	end

	hs.notify.show("Hammerspoon", "Bootstrap", "Finished")
end

if hs.spoons.isInstalled("SpoonInstall") then
	hs.loadSpoon("SpoonInstall")
else
	bootstrapSpoonInstall()
	spoon.SpoonInstall:updateAllRepos()
end
