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

local group = vim.api.nvim_create_augroup("Markdown Snippets", { clear = true })
local file_pattern = "*.md"

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

-- Begin Refactoring --
--
cs( -- lorem
  "adr-small",
  fmt(
    [[
# Use Plain JUnit5 for advanced test assertions

## Context and Problem Statement

How to write readable test assertions?
How to write readable test assertions for advanced tests?

## Considered Options

* Plain JUnit5
* Hamcrest
* AssertJ

## Decision Outcome

Chosen option: "Plain JUnit5", because it is a standard framework and the features of the other frameworks do not outweigh the drawbrack of adding a new dependency.

  ]],
    {
      -- i(1, ""),
      -- i(2, "// TODO:"),
    }
  )
)   --}}}

cs( -- eslint configuration
  "adr-full",
  fmt(
    [[
---
parent: Architectural Decisions
nav_order: 9
---
# Use Plain JUnit5 for advanced test assertions

## Context and Problem Statement

How to write readable test assertions?
How to write readable test assertions for advanced tests?

## Considered Options

* Plain JUnit5
* Hamcrest
* AssertJ

## Decision Outcome

Chosen option: "Plain JUnit5", because comes out best (see below).

### Consequences

* Good, because tests are more readable
* Good, because more easy to write tests
* Good, because more readable assertions
* Bad, because more complicated testing leads to more complicated assertions

## Pros and Cons of the Options

### Plain JUnit5

Homepage: <https://junit.org/junit5/docs/current/user-guide/>
JabRef testing guidelines: <https://devdocs.jabref.org/getting-into-the-code/code-howtos#test-cases>

Example:

```java
String actual = markdownFormatter.format(source);
assertTrue(actual.contains("Markup<br />"));
assertTrue(actual.contains("<li>list item one</li>"));
assertTrue(actual.contains("<li>list item 2</li>"));
assertTrue(actual.contains("> rest"));
assertFalse(actual.contains("\n"));
```

* Good, because Junit5 is "common Java knowledge"
* Bad, because complex assertions tend to get hard to read
* Bad, because no fluent API

### Hamcrest

Homepage: <https://github.com/hamcrest/JavaHamcrest>

* Good, because offers advanced matchers (such as `contains`)
* Bad, because not full fluent API
* Bad, because entry barrier is increased

### AssertJ

Homepage: <https://joel-costigliola.github.io/assertj/>

Example:

```java
assertThat(markdownFormatter.format(source))
        .contains("Markup<br />")
        .contains("<li>list item one</li>")
        .contains("<li>list item 2</li>")
        .contains("> rest")
        .doesNotContain("\n");
```

* Good, because offers fluent assertions
* Good, because allows partial string testing to focus on important parts
* Good, because assertions are more readable
* Bad, because not commonly used
* Bad, because newcomers have to learn an additional language to express test cases
* Bad, because entry barrier is increased
* Bad, because expressions of test cases vary from unit test to unit test

## More Information

German comparison between Hamcrest and AssertJ: <https://www.sigs-datacom.de/uploads/tx_dmjournals/philipp_JS_06_15_gRfN.pdf>.
  ]],
    {
      -- i(1, ""),
      -- i(2, "// TODO:"),
    }
  )
)                                                                      --}}}

cs("jsb", { t("```javascript"), i(1, ""), t("```") }, { "jcl", "jj" }) -- console.log
-- End Refactoring --

return snippets, autosnippets
