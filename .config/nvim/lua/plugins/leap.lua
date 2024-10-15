return {
  'ggandor/leap.nvim',
  priority = 100,
  config = function()
    require('leap').create_default_mappings()
  end
}
