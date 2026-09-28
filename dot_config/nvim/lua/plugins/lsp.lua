return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ruby_lsp = {
          mason = false,
          cmd = { vim.fn.expand("~/.rbenv/shims/ruby-lsp") },
        },
        rubocop = {
          mason = false,
          cmd = { vim.fn.expand("~/.rbenv/shims/rubocop"), "--lsp" },
        },
        pyright = {
          mason = false,
          cmd = { "uv", "run", "pyright-langserver", "--stdio" },
        },
        hls = {
          mason = false,
        },
      },
    },
  },
}
