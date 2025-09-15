return {
	"startup-nvim/startup.nvim",
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-file-browser.nvim",
	},
	config = function()
		require("startup").setup({
			theme = "dashboard",
			mapping_keys = true,
			cursor_column = 1,
		})
	end,
}
