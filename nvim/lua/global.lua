function file_exists(path)
  local stat = vim.loop.fs_stat(path)
  return stat and stat.type == 'file' or false
end

