return {
  "diepm/vim-rest-console",
  config = function()
    vim.cmd [[ let g:vrc_curl_opts = { '--connect-timeout' : 10, '-L': '', '-sS': '', '-i': '', '--max-time': 60, '--ipv4': '', '-k': '', } ]]
  end
}
