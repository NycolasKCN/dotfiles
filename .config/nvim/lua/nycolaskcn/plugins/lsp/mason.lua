return {
  "mason-org/mason-lspconfig.nvim",
  opts = {
    -- list of servers for mason to install
    ensure_installed = {
      "ast_grep",
      "ts_ls",
      "html",
      "cssls",
      "tailwindcss",
      "svelte",
      "lua_ls",
      "graphql",
      "emmet_ls",
      "prismals",
      "pyright",
      "eslint",
      "clangd"
    },
    automatic_enable = true,
  },
  dependencies = {
    {
      "mason-org/mason.nvim",
      opts = {
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      },
    },
    {
      "neovim/nvim-lspconfig",
    },
  }
}

