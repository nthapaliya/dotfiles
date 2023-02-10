-- Copied from COQ source code
M.lsp_ensure_capabilities = function(capabilities)
  local spec1 = vim.lsp.protocol.make_client_capabilities()

  local spec2 = {
    textDocument = {
      completion = {
        completionItem = {
          deprecatedSupport = true,
          insertReplaceSupport = true,
          insertTextModeSupport = { valueSet = { 1, 2 } },
          labelDetailsSupport = true,
          preselectSupport = true,
          resolveSupport = { properties = {} },
          snippetSupport = true,
          tagSupport = { valueSet = { 1 } },
        },
      },
    },
  }
  local maps = (capabilities or {}) and { spec2 } or { spec1, spec2 }
  local new = vim.tbl_deep_extend("force", capabilities or vim.empty_dict(), unpack(maps))
  return new
end

-- TODO: investigate why this causes everything to freeze
return {
  "ms-jpq/coq_nvim",
  branch = "coq",
  dependencies = { "ms-jpq/coq.artifacts", branch = "artifacts" },
  event = "InsertEnter",
  init = function()
    vim.g.coq_settings = {
      ["keymap.jump_to_mark"] = "",
      -- ["keymap.manual_complete"] = "<c-n>",
      -- ["completion.always"] = false,
      auto_start = "shut-up",
    }
  end,
}
