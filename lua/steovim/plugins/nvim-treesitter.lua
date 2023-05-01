return {
	'nvim-treesitter/nvim-treesitter',
	config = function() 
        require('nvim-treesitter.configs').setup({
            highlight = { 
                enable = true, 
                  disable = { "lua" },
            },
            incremental_selection = { enable = true },
            textobjects = { enable = true },
        })
        vim.cmd(":TSUpdate")
    end
}
