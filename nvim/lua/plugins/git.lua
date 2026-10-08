local snacks = require ("snacks")
local gitsigns = require("gitsigns")
gitsigns.setup({
  signs = {
    add = { text = "│" }, change = { text = "│" }, delete = { text = "_" },
    topdelete = { text = "‾" }, changedelete = { text = "~" },
    untracked = { text = "┆" },
  },
  on_attach = function(buf)
    local function map(lhs, rhs, desc)
      vim.keymap.set("n", lhs, rhs, { buffer = buf, desc = desc })
    end
    map("]h", function() gitsigns.nav_hunk("next") end, "Next git hunk")
    map("[h", function() gitsigns.nav_hunk("prev") end, "Previous git hunk")
    map("<leader>gp", gitsigns.preview_hunk, "Preview hunk")
    map("<leader>gs", gitsigns.stage_hunk, "Stage hunk")
    map("<leader>gr", gitsigns.reset_hunk, "Reset hunk")
    map('<leader>gd', gitsigns.diffthis, "Diff")
    map('<leader>gD', function() gitsigns.diffthis('~') end, "Reset diff")
    map("<leader>gb", function() gitsigns.blame_line({ full = true }) end, "git blame")
  end,
})
