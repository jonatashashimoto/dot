return {
  "toppair/peek.nvim",
  event = { "VeryLazy" },
  build = "deno task --quiet build:fast",
  config = function()
    require("peek").setup()
    -- refer to `configuration to change defaults`

    vim.api.nvim_create_user_command("Preview", require("peek").open, {})
    vim.api.nvim_create_user_command("PreviewClose", require("peek").close, {})
  end,
}
