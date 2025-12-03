return {
  "mistricky/codesnap.nvim",
  build = "make",
  keys = {
    { "<leader>co", "<cmd>CodeSnap<cr>", mode = "x", desc = "Save selected code snapshot into clipboard" },
  },
  opts = {
    save_path = os.getenv("XDG_PICTURES_DIR") or "~/Pictures",
    has_breadcrumbs = true,
    bg_theme = "grape",
    watermark = "",
    code_font_family = "FantasqueSansM Nerd Font Mono",
    mac_window_bar = false,
    bg_x_padding = 40,
    bg_y_padding = 40,
  },
}
