return {
  {
    "mrcjkb/rustaceanvim",
    ft = "rust",
    keys = {
      {
        "<leader>rr",
        function()
          vim.cmd.RustLsp("runnables")
        end,
        desc = "Rust Runnables",
        ft = "rust",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        bacon_ls = {
          enabled = false,
        },
        rust_analyzer = { enabled = true }, -- temporary fix to diagnostics not showing
      },
    },
  },
}
