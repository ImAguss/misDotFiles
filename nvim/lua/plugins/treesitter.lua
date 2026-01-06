return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, default_opts)
      local my_parsers = {
        "bash", "c", "cpp", "css", "go", "html",
        "javascript", "json", "lua", "markdown",
        "python", "rust", "toml", "tsx", "typescript",
        "vim", "vimdoc", "yaml"
      }
      local merged_parsers = vim.list_extend(
        default_opts.ensure_installed or {},
        my_parsers
      )
      return vim.tbl_deep_extend("force", default_opts, {
        ensure_installed = merged_parsers,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },
}
