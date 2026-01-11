return {
  {
    "stevearc/conform.nvim",
    event = 'BufWritePre',
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua" },
          python = { "black", "isort" },
          javascript = { "prettier" },
          typescript = { "prettier" },
          javascriptreact = { "prettier" },
          typescriptreact = { "prettier" },
          html = { "prettier" },
          css = { "prettier" },
          json = { "prettier" },
          yaml = { "prettier" },
          markdown = { "prettier" },
          rust = { "rustfmt" },
          go = { "gofmt", "goimports" },
          c = { "clang_format" },
          cpp = { "clang_format" },
          sh = { "shfmt" },
        },
        
        format_on_save = {
          timeout_ms = 500,
          lsp_fallback = true,
        },
        
        formatters = {
          prettier = {
            prepend_args = { "--single-quote", "--jsx-single-quote" },
          },
          stylua = {
            prepend_args = { "--indent-width", "2", "--indent-type", "Spaces" },
          },
        },
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
}
