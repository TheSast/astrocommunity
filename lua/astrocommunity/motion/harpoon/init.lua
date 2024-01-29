local prefix = "<leader><leader>"
local harpoon = require("harpoon")
local term_string = vim.fn.exists "$TMUX" == 1 and "tmux" or "term"
local maps = { n = {} }
local icon = vim.g.icons_enabled and "󱡀 " or ""
maps.n[prefix] = { desc = icon .. "Harpoon" }
require("astronvim.utils").set_mappings(maps)
return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    cmd = { "Harpoon" },
    keys = {
      { prefix .. "a", function() harpoon:list():append() end, desc = "Add file" },
      { prefix .. "e", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = "Toggle quick menu" },
      {
        "<C-x>",
        function()
          vim.ui.input({ prompt = "Harpoon mark index: " }, function(input)
            local num = tonumber(input)
            if num then harpoon:list():select(num) end
          end)
        end,
        desc = "Goto index of mark",
      },
      { "<C-p>", function() harpoon:list():prev() end, desc = "Goto previous mark" },
      { "<C-n>", function() harpoon:list():next() end, desc = "Goto next mark" },
      { prefix .. "m", "<cmd>Telescope harpoon marks<CR>", desc = "Show marks in Telescope" },
      {
        prefix .. "t",
        function()
          vim.ui.input({ prompt = term_string .. " window number: " }, function(input)
            local num = tonumber(input)
            if num then harpoon.term.gotoTerminal(num) end
          end)
        end,
        desc = "Go to " .. term_string .. " window",
      },
    },
  },
  {
    "catppuccin/nvim",
    optional = true,
    ---@type CatppuccinOptions
    opts = { integrations = { harpoon = true } },
  },
}
