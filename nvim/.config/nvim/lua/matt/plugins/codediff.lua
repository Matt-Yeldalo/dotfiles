return {
  "esmuellert/codediff.nvim",
  event = "VeryLazy",
  config = function()
    require("codediff").setup()
  end,
  keys = {
    { "<leader>hd", "<cmd>CodeDiff HEAD<cr>", desc = "Diff against HEAD" },
    { "<leader>hi", "<cmd>CodeDiff<cr>", desc = "Diff against index" },
  },
}

