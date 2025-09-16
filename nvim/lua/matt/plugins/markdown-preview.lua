return {
  'iamcco/markdown-preview.nvim',
  cmd = { 'MarkdownPreviewtoggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
  ft = {'markdown'},
  build = function() vim.fn['mkdp#util#install']() end,
}
