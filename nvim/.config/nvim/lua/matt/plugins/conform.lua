-- Formatting setup via Conform.nvim
-- Prefer LSP formatting when available (ruby-lsp), and use external tools for others.

return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format { async = true, lsp_format = 'prefer' }
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  opts = {
    formatters = {
      erb_formatter = {
        command = os.getenv 'HOME' .. '/.rbenv/shims/erb-format',
        args = { '--stdin', '--print-width', '125' },
      },
      rubocop = {
        command = os.getenv 'HOME' .. '/.rbenv/shims/rubocop',
        args = { '--auto-correct', '--stdin', '%filepath' },
        stdin = true,
      },
    },
    notify_on_error = true,
    formatters_by_ft = {
      lua = { 'stylua' },
      javascript = { 'prettierd', 'prettier', stop_after_first = true },
      typescript = { 'prettierd', 'prettier', stop_after_first = true },
      typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
      javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
      css = { 'prettierd', 'prettier', stop_after_first = true },
      scss = { 'prettierd', 'prettier', stop_after_first = true },
      markdown = { 'markdownlint' },
      html = { 'htmlbeautifier' },
      ruby = { 'rubocop'},
      erb = { 'erb_formatter' },
      eruby = { 'erb_formatter' },
    },
  },
}
