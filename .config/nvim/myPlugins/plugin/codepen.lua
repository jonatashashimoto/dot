local curl = require("plenary.curl")
function createPen()
	local res = curl.post("https://codepen.io/pen/define", {
		body = {data = '{"title": "New Pen!", "html": "<div>HEY BOY</div>"};'},
	})
	print(vim.inspect.inspect(res))
end

vim.cmd([[command! Codepen :lua createPen()]]) --}}}
-- print(vim.inspect.inspect(res))
