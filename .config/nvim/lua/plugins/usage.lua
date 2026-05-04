local function text_format(symbol)
  local res = {}
  local round_start = { "", "SymbolUsageRounding" }
  local round_end = { "", "SymbolUsageRounding" }
  local stacked_functions_content = symbol.stacked_count > 0 and ("+%s"):format(symbol.stacked_count) or ""

  if symbol.references then
    local usage = symbol.references <= 1 and "usage" or "usages"
    local num = symbol.references == 0 and "no" or symbol.references
    table.insert(res, round_start)
    table.insert(res, { "󰌹 ", "SymbolUsageRef" })
    table.insert(res, { ("%s %s"):format(num, usage), "SymbolUsageContent" })
    table.insert(res, round_end)
  end

  if symbol.definition then
    if #res > 0 then
      table.insert(res, { " ", "NonText" })
    end
    table.insert(res, round_start)
    table.insert(res, { "󰳽 ", "SymbolUsageDef" })
    table.insert(res, { symbol.definition .. " defs", "SymbolUsageContent" })
    table.insert(res, round_end)
  end

  if symbol.implementation then
    if #res > 0 then
      table.insert(res, { " ", "NonText" })
    end
    table.insert(res, round_start)
    table.insert(res, { "󰡱 ", "SymbolUsageImpl" })
    table.insert(res, { symbol.implementation .. " impls", "SymbolUsageContent" })
    table.insert(res, round_end)
  end

  if stacked_functions_content ~= "" then
    if #res > 0 then
      table.insert(res, { " ", "NonText" })
    end
    table.insert(res, round_start)
    table.insert(res, { " ", "SymbolUsageImpl" })
    table.insert(res, { stacked_functions_content, "SymbolUsageContent" })
    table.insert(res, round_end)
  end

  return res
end

return {
  "Wansmer/symbol-usage.nvim",
  event = "LspAttach",
  config = function()
    vim.opt.termguicolors = true

    local function setup_colors()
      -- Função atualizada para Neovim 0.10+ / 0.12
      local function get_hl(name)
        -- 'link = false' resolve o link e traz os valores reais de cor
        local hl = vim.api.nvim_get_hl(0, { name = name, link = false })

        local function parse_color(val)
          return val and string.format("#%06x", val) or nil
        end

        return {
          fg = parse_color(hl.fg),
          bg = parse_color(hl.bg),
        }
      end

      -- Captura as cores do tema
      local cursorline = get_hl("CursorLine")
      local comment = get_hl("Comment")
      local function_hl = get_hl("Function")
      local type_hl = get_hl("Type")

      -- FALLBACKS: Se o tema retornar nil (transparente), usamos valores padrão
      local bg_final = cursorline.bg or "#2e3440" -- substitua pelo seu cinza escuro padrão
      local fg_final = comment.fg or "#616e88"

      -- APLICAÇÃO FORÇADA
      vim.api.nvim_set_hl(0, "SymbolUsageRounding", { fg = bg_final, italic = true })
      vim.api.nvim_set_hl(0, "SymbolUsageContent", { bg = bg_final, fg = fg_final, italic = true })
      vim.api.nvim_set_hl(0, "SymbolUsageRef", { fg = function_hl.fg or "#81a1c1", bg = bg_final, italic = true })
      vim.api.nvim_set_hl(0, "SymbolUsageDef", { fg = type_hl.fg or "#8fbcbb", bg = bg_final, italic = true })
      vim.api.nvim_set_hl(0, "SymbolUsageImpl", { fg = "#a3be8c", bg = bg_final, italic = true })
    end

    -- Executa imediatamente e garante persistência
    setup_colors()

    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = setup_colors,
    })

    require("symbol-usage").setup({
      text_format = text_format,
      disable = { lsp = {}, filetypes = {}, cond = {} },
      vt_position = "end_of_line",
    })
  end,
}
