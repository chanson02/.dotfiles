return {
  'unblevable/quick-scope',
  keys = { 'f', 'F', 't', 'T' },
  init = function()
    vim.cmd [[ let g:qs_highlight_on_keys = ['f', 'F', 't', 'T'] ]]
    vim.cmd [[ let g:qs_max_chars=150 ]]
  end,
  config = function()
    vim.cmd [[
    highlight QuickScopePrimary guifg=yellow ctermfg=yellow
    highlight QuickScopeSecondary guifg=cyan ctermfg=cyan
    ]]
  end
}

-- gui=underline & cterm=underline
