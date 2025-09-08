return {
  'sainnhe/sonokai',
  lazy = false,
  name = 'sonokai',
  priority = 1000,
  config = function()
    vim.g.sonokai_style = 'shusia'
    vim.g.sonokai_better_performance = 1
    vim.g.sonokai_enable_italic = 1
    vim.g.sonokai_diagnostic_text_highlight = 1
    vim.g.sonokai_diagnostic_line_highlight = 1
    vim.g.sonokai_diagnostic_virtual_text = 'colored'
    vim.g.sonokai_current_word = 'bold'
    vim.g.sonokai_show_eob = 0
    vim.cmd.colorscheme 'sonokai'
  end,
}
