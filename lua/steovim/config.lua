return {
    use_new_lsp_and_cmp_config = vim.fn.environ()['NEW_LSP'] == "1"
}
