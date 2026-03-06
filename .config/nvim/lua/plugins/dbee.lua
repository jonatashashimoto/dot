return {
  "kndndrj/nvim-dbee",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim", -- dbee também costuma precisar deste
  },
  build = function()
    -- Install tries to automatically detect the install method.
    -- If it fails, try calling it with one of these parameters:
    --    "curl", "wget", "bitsadmin", "go"
    require("dbee").install()
  end,
  config = function()
    require("dbee").setup(--[[optional config]])
  end,
}
