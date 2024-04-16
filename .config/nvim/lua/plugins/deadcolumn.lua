return {
  'Bekaboo/deadcolumn.nvim',
  config = function()
    local opts = {
      scope = 'line', ---@type string|fun(): integer
      ---@type string[]|fun(mode: string): boolean
      modes = function(mode)
        return true
        -- return mode:find('^[ictRss\x13]') ~= nil
      end,
      blending = {
        threshold = 0.01,
        colorcode = '#111111',
        hlgroup = { 'NonText', 'bg' },
      },
      warning = {
        alpha = 0.5,
        offset = 0,
        colorcode = '#FF0000',
        hlgroup = { 'Error', 'bg' },
      },
      extra = {
        ---@type string?
        -- follow_tw = nil,
      },
    }

    require('deadcolumn').setup(opts) -- Call the setup function
  end
}
