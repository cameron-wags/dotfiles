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

local function settings_for_server(name)
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

local function attach(client, bufnr)
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
  -- n_map('<leader>q', vim.diagnostic.setloclist)

  -- if client.name == 'tsserver' then
  --   client.server_capabilities.document_formatting = false
  -- end
  -- if client.server_capabilities.document_highlight then
  --   vim.api.nvim_exec([[
  --     hi link LspReferenceRead Visual
  --     hi link LspReferenceText Visual
  --     hi link LspReferenceWrite Visual
  --     augroup lsp_document_highlight
  --       autocmd! * <buffer>
  --       autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
  --       autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
  --     augroup END
  --    ]], false
  --   )
  -- end
end

-- Add additional capabilities supported by nvim-cmp
local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not cmp_nvim_lsp_ok then
  return
end

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
-- local lspconfig_ok, lspconfig = pcall(require, 'lspconfig')
-- if not lspconfig_ok then
--   return
-- end
local cmp_capabilities = vim.lsp.protocol.make_client_capabilities()
cmp_capabilities = cmp_nvim_lsp.update_capabilities(cmp_capabilities)

mason_lspconfig.setup_handlers({
  function(server_name)
    require 'lspconfig'[server_name].setup {
      on_attach = attach,
      settings = settings_for_server(server_name),
      capabilities = cmp_capabilities,
    }
  end
})
