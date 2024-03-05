local ls = require("luasnip") --{{{
local s = ls.s
local i = ls.i
local t = ls.t

local d = ls.dynamic_node
local c = ls.choice_node
local f = ls.function_node
local sn = ls.snippet_node

local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

local snippets, autosnippets = {}, {} --}}}

local group = vim.api.nvim_create_augroup("Javascript Snippets", { clear = true })
local file_pattern = "*.js"

local function cs(trigger, nodes, opts) --{{{
	local snippet = s(trigger, nodes)
	local target_table = snippets

	local pattern = file_pattern
	local keymaps = {}

	if opts ~= nil then
		-- check for custom pattern
		if opts.pattern then
			pattern = opts.pattern
		end

		-- if opts is a string
		if type(opts) == "string" then
			if opts == "auto" then
				target_table = autosnippets
			else
				table.insert(keymaps, { "i", opts })
			end
		end

		-- if opts is a table
		if opts ~= nil and type(opts) == "table" then
			for _, keymap in ipairs(opts) do
				if type(keymap) == "string" then
					table.insert(keymaps, { "i", keymap })
				else
					table.insert(keymaps, keymap)
				end
			end
		end

		-- set autocmd for each keymap
		if opts ~= "auto" then
			for _, keymap in ipairs(keymaps) do
				vim.api.nvim_create_autocmd("BufEnter", {
					pattern = pattern,
					group = group,
					callback = function()
						vim.keymap.set(keymap[1], keymap[2], function()
							ls.snip_expand(snippet)
						end, { noremap = true, silent = true, buffer = true })
					end,
				})
			end
		end
	end

	table.insert(target_table, snippet) -- insert snippet into appropriate table
end --}}}

-- Old Style --

local if_fmt_arg = { --{{{
	i(1, ""),
	c(2, { i(1, "LHS"), i(1, "10") }),
	c(3, { i(1, "==="), i(1, "<"), i(1, ">"), i(1, "<="), i(1, ">="), i(1, "!==") }),
	i(4, "RHS"),
	i(5, "//TODO:"),
}
local if_fmt_1 = fmt(
	[[
{}if ({} {} {}) {};
    ]],
	vim.deepcopy(if_fmt_arg)
)
local if_fmt_2 = fmt(
	[[
{}if ({} {} {}) {{
  {};
}}
    ]],
	vim.deepcopy(if_fmt_arg)
)

local if_snippet = s(
	{ trig = "IF", regTrig = false, hidden = true },
	c(1, {
		if_fmt_1,
		if_fmt_2,
	})
) --}}}
local function_fmt = fmt( --{{{
	[[
function {}({}) {{
  {}
}}
    ]],
	{
		i(1, "myFunc"),
		c(2, { i(1, "arg"), i(1, "") }),
		i(3, "//TODO:"),
	}
)

local function_snippet = s({ trig = "f[un]?", regTrig = true, hidden = true }, function_fmt)
local function_snippet_func = s({ trig = "func" }, vim.deepcopy(function_fmt)) --}}}

local short_hand_if_fmt = fmt( --{{{
	[[
if ({}) {}
{}
    ]],
	{
		d(1, function(_, snip)
			-- return sn(1, i(1, snip.captures[1]))
			return sn(1, t(snip.captures[1]))
		end),
		d(2, function(_, snip)
			return sn(2, t(snip.captures[2]))
		end),
		i(3, ""),
	}
)
local short_hand_if_statement = s({ trig = "if[>%s](.+)>>(.+)\\", regTrig = true, hidden = true }, short_hand_if_fmt)

local short_hand_if_statement_return_shortcut = s({ trig = "(if[>%s].+>>)[r<]", regTrig = true, hidden = true }, {
	f(function(_, snip)
		return snip.captures[1]
	end),
	t("return "),
}) --}}}
table.insert(autosnippets, if_snippet)
table.insert(autosnippets, short_hand_if_statement)
table.insert(autosnippets, short_hand_if_statement_return_shortcut)
table.insert(snippets, function_snippet)
table.insert(snippets, function_snippet_func)

-- Begin Refactoring --
--
cs( -- lorem
	"lorem",
	fmt(
		[[
Se hoje é o dia das crianças... Ontem eu disse: 
o dia da criança é o dia da mãe, dos pais, das professoras, 
mas também é o dia dos animais, sempre que você olha uma criança, 
há sempre uma figura oculta, que é um cachorro atrás. 
O que é algo muito importante!

Não acho que quem ganhar ou quem perder, 
nem quem ganhar nem perder, vai ganhar ou perder. 
Vai todo mundo perder.

Nós não vamos colocar uma meta. Nós vamos deixar uma meta aberta. 
Quando a gente atingir a meta, nós dobramos a meta.

Eu já entendi que você entende, pois se você não tivesse entendido 
não entenderia que você teria entendido para ser explicado antes 
de você entender.

Nós somos Piratas!
Eu amo heróis mas não quero ser um.
Digamos que tem um pedaço de carne,
Piratas farão um banquete e comerão a carne
Mas heróis vão dividir a carne com outras pessoas.
Eu quero toda a carne!
-- Mugiwara no Luffy


  ]],
		{
			-- i(1, ""),
			-- i(2, "// TODO:"),
		}
	)
) --}}}

cs( -- eslint configuration
	"eslint",
	fmt(
		[[
 {{
  "env":{{
    "es6": true,
    "node": true,
    "mocha": true,
    "jest": true
  }},
  "parserOptions": {{
    "ecmaVersion": 9,
    "ecmaFeatures": {{
      "experimentalObjectRestSpread": true
    }},
    "sourceType": "module"
  }},
  "globals": {{
    "dredd": "writable",
    "requireApp": "readonly"
  }},
  "extends": "eslint:recommended",
  "rules": {{
    "no-console": "off",
    "indent": [
      "error",
      2
    ],
    "linebreak-style": [
      "error",
      "unix"
    ],
    "quotes": [
      "error",
      "single"
    ],
    "semi": [
      "error",
      "never"
    ],
    "comma-dangle": [
      "error",
      "always-multiline"
    ]
  }}
}}
  ]],
		{
			-- i(1, ""),
			-- i(2, "// TODO:"),
		}
	)
) --}}}

-- End Refactoring --

return snippets, autosnippets
