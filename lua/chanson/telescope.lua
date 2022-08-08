local status_ok, telescope = pcall(require, 'telescope')
if not status_ok then
  print('Telescope failed to install')
  return
end

telescope.load_extension('media_files') -- I havent tested this yet

telescope.setup({

})
