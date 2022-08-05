local mason_ok, mason = pcall(require, 'mason')
if not mason_ok then
  return
end

local mason_lspconfig_ok, mason_lspconfig = pcall(require, 'mason-lspconfig')
if not mason_lspconfig_ok then
  return
end

mason.setup {
  ui = {
    border = 'rounded',
    icons = {
      package_installed = '✓',
      package_pending = '➜',
      package_uninstalled = '✗'
    }
  }
}

mason_lspconfig.setup {
  ensure_installed = {
    'eslint',
    'sumneko_lua',
    'tsserver',
  },
  automatic_installation = true,
}

local settings_for_server = function(name)
  if name == 'sumneko_lua' then
    return {
      Lua = {
        diagnostics = {
          globals = { 'vim' },
        },
        workspace = {
          library = {
            [vim.fn.expand('$VIMRUNTIME/lua')] = true,
            [vim.fn.stdpath('config') .. '/lua'] = true,
          },
        },
      },
    }
  end
end

local attach = function(client, bufnr)
  local buf_opts = { noremap = true, silent = true, buffer = bufnr }
  local n_map = function(bind, action)
    return vim.keymap.set('n', bind, action, buf_opts)
  end
  n_map('gD', vim.lsp.buf.declaration)
  n_map('gd', vim.lsp.buf.definition)
  n_map('K', vim.lsp.buf.hover)
  n_map('gi', vim.lsp.buf.implementation)
  n_map('<C-k>', vim.lsp.buf.signature_help)
  n_map('<leader>wa', vim.lsp.buf.add_workspace_folder)
  n_map('<leader>wr', vim.lsp.buf.remove_workspace_folder)
  n_map('<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end)
  n_map('<leader>rn', vim.lsp.buf.rename)
  n_map('<leader>ca', vim.lsp.buf.code_action)
  n_map('gr', vim.lsp.buf.references)
  n_map('<leader>of', vim.diagnostic.open_float)
  n_map('[d', vim.diagnostic.goto_prev)
  n_map(']d', vim.diagnostic.goto_next)
  n_map('<leader>ff', vim.lsp.buf.formatting)

  vim.api.nvim_create_autocmd('CursorHold', {
    buffer = bufnr,
    callback = function()
      local opts = {
        focusable = false,
        close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter', 'FocusLost' },
        border = 'rounded',
        source = 'always',
        prefix = ' ',
        scope = 'cursor',
      }
      vim.diagnostic.open_float(nil, opts)
    end
  })
  -- n_map('<leader>q', vim.diagnostic.setloclist)
end

-- Add additional capabilities supported by nvim-cmp
local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not cmp_nvim_lsp_ok then
  return
end
local capabilities_for_server = function(server_name)
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = cmp_nvim_lsp.update_capabilities(capabilities)
  -- if server_name == 'tsserver' then
  --   capabilities.document_formatting = false
  -- end
  return capabilities
end

mason_lspconfig.setup_handlers {
  function(server_name)
    require 'lspconfig'[server_name].setup {
      on_attach = attach,
      settings = settings_for_server(server_name),
      capabilities = capabilities_for_server(server_name),
    }
  end
}

local setsign = function(sname, stext)
  vim.fn.sign_define(sname, { texthl = sname, text = stext, numhl = '' })
end

setsign('DiagnosticSignError', '✗')
setsign('DiagnosticSignWarn', '!')
setsign('DiagnosticSignInfo', '')
setsign('DiagnosticSignHint', '')

vim.diagnostic.config {
  virtual_text = {
    prefix = '',
    spacing = 2,
  },
  signs = true,
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = 'minimal',
    border = 'rounded',
    source = 'always',
    header = '',
    prefix = '',
  },
}

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = 'rounded',
})

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = 'rounded',
})
