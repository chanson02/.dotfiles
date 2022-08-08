local status_ok, npairs = pcall(require, "nvim-autopairs")
if not status_ok then
  print "Failed to load Autopairs"
  return
end

npairs.setup({
  check_ts = true -- Uses tree sitter to know where to autopair
})
