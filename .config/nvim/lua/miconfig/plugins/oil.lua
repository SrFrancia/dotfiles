return {
	{
		"refractalize/oil-git-status.nvim",

		dependencies = {
			{
				"stevearc/oil.nvim",
				opts = {
					view_options = {
						show_hidden = true,
					},
					win_options = {
						signcolumn = "yes:2",
					},
				},
				-- Optional dependencies
				dependencies = {
					{ "echasnovski/mini.icons", opts = {} },
				},
			},
		},

		config = true,
	},
}
