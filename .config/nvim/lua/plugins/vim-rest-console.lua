return {
  "diepm/vim-rest-console",
  config = function()
    vim.g.vrc_response_default_content_type = 'application/json'
    vim.g.vrc_auto_format_response_patterns = {
      json = 'jq',
    }


-- let g.vrc_connect_timeout = 10
-- let g.vrc_cookie_jar = '/path/to/cookie'
-- vim.g.vrc_follow_redirects = 1
-- vim.g.vrc_include_response_header = 0
-- vim.g.vrc_max_time = 60
-- vim.g.vrc_resolve_to_ipv4 = 1
-- vim.g.vrc_ssl_secure = 1


    vim.cmd [[ let g:vrc_curl_opts = { '--connect-timeout' : 30, '-L': '', '-sS': '', '-i': '', '--max-time': 60, '--ipv4': '', '-k': '', } ]]
  end
}
