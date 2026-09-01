return {
	"stevearc/overseer.nvim",
	opts = {
		templates = { "builtin" },
		disable_template_modules = { "overseer.template.cargo" },
		task_list = {
			direction = "right",
			default_detail = 2,
			keymaps = {
				["<CR>"] = { "keymap.run_action", opts = { action = "open float" }, desc = "Open float output" },
			},
		},
		component_aliases = {
			default = {
				"user.on_start_notify",
				"on_exit_set_status",
				{ "on_complete_notify", statuses = { "FAILURE", "SUCCESS" } },
				"on_complete_dispose",
			},
		},
	},
	keys = {
		{ "<leader>to", "<cmd>OverseerToggle<cr>", desc = "Toggle Overseer Task Panel" },
		{ "<leader>tr", "<cmd>OverseerRun<cr>", desc = "Run Workspace Task" },
		{
			"<leader>tc",
			function()
				require("overseer_cargo").pick()
			end,
			desc = "Cargo Task (submenu)",
		},
		{ "<leader>tq", "<cmd>OverseerQuickAction<cr>", desc = "Overseer Quick Action" },
		{ "<leader>tR", "<cmd>OverseerRestartLast<cr>", desc = "Restart Last Task" },
	},
}
