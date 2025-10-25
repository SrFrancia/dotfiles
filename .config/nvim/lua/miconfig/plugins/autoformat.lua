return { -- Autoformat
	"stevearc/conform.nvim",
	lazy = false,
	keys = {
		{
			"<leader>f",
			function()
				require("conform").format({ async = true, lsp_fallback = false })
			end,
			mode = "",
			desc = "[F]ormat buffer",
		},
	},
	opts = {
		notify_on_error = true,
		-- format_on_save = function(bufnr)
		-- 	-- Disable "format_on_save lsp_fallback" for languages that don't
		-- 	-- have a well standardized coding style. You can add additional
		-- 	-- languages here or re-enable it for the disabled ones.
		-- 	local disable_filetypes = { c = true, cpp = true, sh = true, lua = true }
		-- 	return {
		-- 		timeout_ms = 500,
		-- 		lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
		-- 	}
		-- end,
		formatters_by_ft = {
			lua = { "stylua" },
			sql = { "pg_format" },
			c = { "clang-format" },
			cpp = { "clang-format" },
			-- Conform can also run multiple formatters sequentially
			-- python = { "isort", "black" },
			--
			-- You can use a sub-list to tell conform to run *until* a formatter
			-- is found.
			-- javascript = { { "prettierd", "prettier" } },
		},
		formatters = {
			stylua = {
				command = "stylua",
				prepend_args = {
					"--indent-width",
					vim.opt.tabstop:get(), -- Use default indentation
					"--indent-type",
					(vim.opt.expandtab:get() and "Spaces" or "Tabs"),
				},
			},
			pg_format = {
				command = "pg_format",
				prepend_args = {
					"--spaces",
					vim.opt.tabstop:get(), -- Use default indentation
					(not vim.opt.expandtab:get() and "--tabs")
				}
			},
			clang_format = {
				command = "clang-format",
				prepend_args = {
					"--style=Google",
				}
			},
		},
	},
}
