return {
	desc = "Notify when the task starts running",
	constructor = function()
		return {
			on_start = function(_, task)
				vim.notify("▶ " .. task.name, vim.log.levels.INFO, { title = "Overseer" })
			end,
		}
	end,
}
