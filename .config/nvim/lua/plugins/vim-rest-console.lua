return {
  "diepm/vim-rest-console",
  config = function()
    vim.g.vrc_response_default_content_type = 'application/json'
    vim.g.vrc_auto_format_response_patterns = {
      json = 'jq',
    }

    vim.cmd [[ let g:vrc_curl_opts = { '--connect-timeout' : 30, '-L': '', '-sS': '', '-i': '', '--max-time': 60, '--ipv4': '', '-k': '', } ]]
  end
}
