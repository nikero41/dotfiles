function Status:name()
	local h = self._tab.current.hovered
	if not h then return ui.Line({}) end

	local linked = ""
	if h.link_to ~= nil then linked = " -> " .. tostring(h.link_to) end
	return ui.Line(" " .. h.name .. linked)
end

require("relative-motions"):setup({
	show_numbers = "relative_absolute",
	only_motions = true,
})

function Current.redraw(self)
	local files = self._folder.window
	if #files == 0 then return self:empty() end

	local hovered_index
	for i, f in ipairs(files) do
		if f.is_hovered then
			hovered_index = i
			break
		end
	end

	local entities, linemodes = {}, {}
	for i, f in ipairs(files) do
		linemodes[#linemodes + 1] = Linemode:new(f):redraw()

		local entity = Entity:new(f)
		entities[#entities + 1] = ui.Line({
			Entity
				:number(i, #self._folder.files, f, hovered_index)
				-- Change the style of the relative numbers column
				:style(
					entity:style():bg("reset"):fg("blue"):dim()
				),
			entity:redraw(),
		}):style(entity:style())
	end

	return {
		ui.List(entities):area(self._area),
		ui.Text(linemodes):area(self._area):align(ui.Align.RIGHT),
	}
end

require("git"):setup()

require("yatline"):setup({
	theme = require("yatline-catppuccin"):setup("mocha"),

	section_separator = { open = "", close = "" },
	show_background = false,

	header_line = {
		left = {
			section_a = { { type = "line", custom = false, name = "tabs", params = { "left" } } },
			section_b = {},
			section_c = {},
		},
		right = {
			section_a = {},
			section_b = { { type = "coloreds", custom = false, name = "count" } },
			section_c = { { type = "coloreds", custom = false, name = "githead" } },
		},
	},

	status_line = {
		left = {
			section_a = { { type = "string", custom = false, name = "tab_mode" } },
			section_b = {
				{ type = "string", custom = false, name = "hovered_file_extension", params = { true } },
				{ type = "string", custom = false, name = "hovered_name" },
			},
			section_c = {
				{ type = "string", custom = false, name = "hovered_size" },
				{ type = "coloreds", custom = false, name = "permissions" },
			},
		},
		right = {
			section_a = { { type = "string", custom = false, name = "cursor_position" } },
			section_b = { { type = "string", custom = false, name = "cursor_percentage" } },
			section_c = {},
		},
	},
})

require("yatline-githead"):setup({
	theme = require("yatline-catppuccin"):setup("mocha"),

	branch_prefix = "",
	branch_borders = "[]",
})
