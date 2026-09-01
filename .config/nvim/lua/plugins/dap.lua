return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio", -- required by dap-ui
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			-- UI setup
			dapui.setup()

			-- Auto open/close UI
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end

			-- js-debug-adapter config (works for Bun, Node, browsers)
			local js_debug = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js"

			for _, adapter in ipairs({ "pwa-node", "pwa-chrome" }) do
				dap.adapters[adapter] = {
					type = "server",
					host = "localhost",
					port = "${port}",
					executable = {
						command = "bun", -- or "node" if you prefer
						args = { js_debug, "${port}" },
					},
				}
			end

			-- Bun / TypeScript launch configs
			for _, lang in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
				dap.configurations[lang] = {
					{
						type = "pwa-node",
						request = "launch",
						name = "Launch with Bun",
						runtimeExecutable = "bun",
						program = "${file}",
						cwd = "${workspaceFolder}",
						sourceMaps = true,
						resolveSourceMapLocations = {
							"${workspaceFolder}/**",
							"!**/node_modules/**",
						},
					},
					{
						type = "pwa-node",
						request = "attach",
						name = "Attach to Bun (--inspect)",
						address = "localhost",
						port = 9229,
						cwd = "${workspaceFolder}",
						sourceMaps = true,
					},
				}
			end

			-- Keymaps
			vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
			vim.keymap.set("n", "<leader>dB", function()
				dap.set_breakpoint(vim.fn.input("Condition: "))
			end, { desc = "Conditional breakpoint" })
			vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue" })
			vim.keymap.set("n", "<leader>dn", dap.step_over, { desc = "Step over" })
			vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step into" })
			vim.keymap.set("n", "<leader>do", dap.step_out, { desc = "Step out" })
			vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "REPL" })
			vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Toggle DAP UI" })
		end,
	},
}
