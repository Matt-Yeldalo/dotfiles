return {
  'L3MON4D3/LuaSnip',
  -- follow latest release.
  version = 'v2.*', -- Replace <CurrentMajor> by the latest released major (first number of latest release)
  -- install jsregexp (optional!).
  build = 'make install_jsregexp',
  --             require('luasnip.loaders.from_vscode').lazy_load()
  dependencies = { 'rafamadriz/friendly-snippets' },
  config = function()
    require('luasnip.loaders.from_vscode').lazy_load()
    -- require('luasnip.loaders.')
    local ls = require 'luasnip'
    ls.filetype_extend('javascript', { 'jsdoc' })
    ls.filetype_extend('eruby', { 'html' })
    ls.filetype_extend('erb', { 'html' })

    -- vim.keymap.set({ 'i' }, '<C-q>e', function()
    --   ls.expand()
    -- end, { silent = true })
    --
    -- vim.keymap.set({ 'i', 's' }, '<C-q>;', function()
    --   ls.jump(1)
    -- end, { silent = true })
    -- vim.keymap.set({ 'i', 's' }, '<C-q>,', function()
    --   ls.jump(-1)
    -- end, { silent = true })
    --
    -- vim.keymap.set({ 'i', 's' }, '<C-Q>', function()
    --   if ls.choice_active() then
    --     ls.change_choice(1)
    -- end
    -- end, { silent = true })
  end,
}
