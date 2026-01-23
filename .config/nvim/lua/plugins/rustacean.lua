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
}
