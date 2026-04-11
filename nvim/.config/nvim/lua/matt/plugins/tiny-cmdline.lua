-- require("vim._core.ui2").enable({ enable = true })
return {
  'rachartier/tiny-cmdline.nvim',
  config = function()
    require('vim._core.ui2').enable { enable = true }
    vim.o.cmdheight = 0
    require('tiny-cmdline').setup()
  end,
}
