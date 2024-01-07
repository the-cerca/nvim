require("autoclose").setup({})
vim.diagnostic.config({
  -- Disable virtual text
  virtual_text = false,

  -- Show signs in the sign column next to the line numbers
  signs = true,

  -- Show diagnostics in a floating window on hover
  float = {
    border = "rounded", -- Use "rounded" borders for the floating window
    source = "always", -- Include the source of the diagnostic (e.g., the linter name)
    header = "",      -- No header text
    prefix = "",      -- No prefix text
  },

  -- Configure the severity of diagnostics
  severity_sort = true,    -- Sort diagnostics by severity
  underline = true,        -- Underline text with diagnostics
  update_in_insert = false, -- Do not update diagnostics while typing in insert mode
})

-- Customize the diagnostic symbols in the sign column (gutter)
local signs = { Error = "❌", Warn = "⚠️", Hint = "💡", Info = "ℹ" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
vim.keymap.set("n", "<leader>e", function()
  vim.diagnostic.open_float(nil, {
    focusable = false,
    close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
    border = "rounded",
    source = "always", -- This will display the source of the diagnostic
  })
end, { noremap = true, silent = true })
