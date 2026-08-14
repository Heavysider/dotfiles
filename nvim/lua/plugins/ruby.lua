-- Ruby comes from the LazyVim extra (lazyvim.plugins.extras.lang.ruby, see lazyvim.json).
-- Overrides: use the gem-installed ruby-lsp from the mise-managed Ruby on PATH
-- instead of a Mason copy, so it always runs under the project's Ruby version.
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ruby_lsp = {
          mason = false,
        },
        -- ruby-lsp already runs RuboCop through the project bundle (diagnostics
        -- and formatting, with the repo's plugin gems). The extra's standalone
        -- rubocop client runs outside the bundle and crashes on any repo whose
        -- .rubocop.yml requires plugin gems.
        rubocop = {
          enabled = false,
        },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        -- format via ruby-lsp (bundle rubocop), not the standalone rubocop CLI
        ruby = { lsp_format = "prefer" },
      },
    },
  },
}
