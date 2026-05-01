local terms = {}

local function vertical_size()
	return math.floor(vim.o.columns * 0.35)
end

local function toggle_agent(name, cmd)
	return function()
		if not terms[name] then
			terms[name] = require("toggleterm.terminal").Terminal:new({
				cmd = cmd,
				direction = "vertical",
				size = vertical_size,
				close_on_exit = false,
				on_open = function()
					vim.cmd("startinsert!")
				end,
			})
		end
		terms[name]:toggle()
	end
end

local function ask_selection()
	local start_line = vim.fn.line("'<")
	local end_line = vim.fn.line("'>")
	local file = vim.fn.expand("%:.")
	if file == "" then
		vim.notify("Cursor agent: current buffer has no file path", vim.log.levels.WARN)
		return
	end

	vim.ui.input({ prompt = "Ask Cursor agent: " }, function(question)
		if not question or question == "" then
			return
		end
		local full_prompt = string.format("@%s:%d-%d %s", file, start_line, end_line, question)
		local term = require("toggleterm.terminal").Terminal:new({
			cmd = "agent " .. vim.fn.shellescape(full_prompt),
			direction = "vertical",
			size = vertical_size,
			close_on_exit = false,
			on_open = function()
				vim.cmd("startinsert!")
			end,
		})
		term:open()
	end)
end

return {
	{
		"akinsho/toggleterm.nvim",
		optional = true,
		keys = {
			{ "<leader>cc", toggle_agent("agent", "agent"), desc = "Toggle Cursor agent" },
			{ "<leader>cr", toggle_agent("agent_resume", "agent resume"), desc = "Resume Cursor agent" },
			{ "<leader>cp", toggle_agent("agent_plan", "agent --mode=plan"), desc = "Cursor agent (plan mode)" },
			{ "<leader>cs", ask_selection, mode = "v", desc = "Ask Cursor agent about selection" },
		},
	},
}
