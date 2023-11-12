return {
  'unblevable/quick-scope',
  init = function()
    vim.cmd [[
    let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
    highlight QuickScopePrimary guifg=yellow gui=underline ctermfg=yellow cterm=underline
    highlight QuickScopeSecondary guifg=cyan gui=underline ctermfg=cyan cterm=underline
    let g:qs_max_chars=150
    ]]
  end
}
