local M = {}

-- TODO: backfill this to template
M.setup = function()
  local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  local config = {
    -- disable virtual text
    virtual_text = false,
    -- show signs
    signs = {
      active = signs,
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })
end

local function lsp_highlight_document(client)
  -- Set autocommands conditional on server_capabilities
  -- if client.server_capabilities.document_highlight then
    local status_ok, illuminate = pcall(require, "illuminate")
    if not status_ok then
      return
    end
    illuminate.on_attach(client)
  -- end
end

local function lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>f", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
  vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    "gl",
    '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({ border = "rounded" })<CR>',
    opts
  )
  vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end

M.on_attach = function(client, bufnr)
-- vim.notify(client.name .. " starting...")
-- TODO: refactor this into a method that checks if string in list
--   if client.name == "tsserver" then
--     client.resolved_capabilities.document_formatting = false
--   end
  lsp_keymaps(bufnr)
  lsp_highlight_document(client)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if status_ok then
  M.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)
end

-- Check if plugin has been loaded by packer.
function M.is_loaded(plugin)
    return packer_plugins[plugin] and packer_plugins[plugin].loaded
end

-- Map keys, registering if which-key is loaded. Skirts around which-key issues.
local function _map(mode, lhs, rhs, description, options)

    local defaults = {  -- Accepted `options`.
        noremap = true,
        silent  = true,
        buffer  = nil,
        nowait  = false,
    }
    if options == nil then
        options = defaults
    else
        options = vim.tbl_extend('keep', options, defaults)
    end

    if M.is_loaded("which-key.nvim") and ('nvsxoiRct'):find(mode) then
        --[[
        Supported modes taken from `check_mode()` [0]. We don't call
        `require("which-key.util").check_mode()` as it will print errors.
          
          [0] https://github.com/folke/which-key.nvim/blob/main/lua/which-key/util.lua
        --]]
        if mode == 'o' then
            -- Avoid redundant entries caused by operator-pending mode mappings.
            description = 'which_key_ignore'
        elseif mode == 't' then
            -- Convert terminal codes and keycodes.
            rhs = vim.api.nvim_replace_termcodes(rhs, true, true, true)
        end

        options.mode = mode
        require("which-key").register({ [lhs] = {rhs, description} }, options)
    else
        -- TODO: Switch to `vim.keymap.set()` in 0.7. Accepts 'buffer' in options.
        if options.buffer then
            local bufnr = options.buffer
            options.buffer = nil
            vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, options)
        else
            vim.api.nvim_set_keymap(mode, lhs, rhs, options)
        end
    end
end

-- Map keys, supporting multiple modes and which-key registration.
function M.map(modes, lhs, rhs, description, options)
    if modes == '' then modes = 'nvo' end

    for mode in modes:gmatch('.') do
        _map(mode, lhs, rhs, description, options)
    end
end

function M.nmap(lhs, rhs, description, options)
    M.map('n', lhs, rhs, description, options)
end

return M
