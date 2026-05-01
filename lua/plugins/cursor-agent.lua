local terms = {}

local function toggle_agent(name, cmd)
	return function()
		if not terms[name] then
			terms[name] = require("toggleterm.terminal").Terminal:new({
				cmd = cmd,
				direction = "vertical",
				size = function()
					return math.floor(vim.o.columns * 0.35)
				end,
				close_on_exit = false,
				on_open = function()
					vim.cmd("startinsert!")
				end,
			})
		end
		terms[name]:toggle()
	end
end

return {
	{
		"akinsho/toggleterm.nvim",
		optional = true,
		keys = {
			{ "<leader>cc", toggle_agent("agent", "agent"), desc = "Toggle Cursor agent" },
			{ "<leader>cr", toggle_agent("agent_resume", "agent resume"), desc = "Resume Cursor agent" },
		},
	},
}
