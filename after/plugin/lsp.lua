local lsp = require('lsp-zero')
local lsp_config = require('lspconfig')
local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

local function allow_format(servers)
  return function(client) return vim.tbl_contains(servers, client.name) end
end

lsp.preset('recommended')

lsp.ensure_installed({
  'tsserver',
  "eslint",
  "lua_ls",
  "html",
})

local on_attach = function(client, bufnr)
	lsp.default_keymaps({buffer = bufnr})

  local my_client = vim.lsp.get_active_clients({ name = "eslint" })

	vim.keymap.set("n", "<leader>lf", function()

    if #my_client == 1 then
      vim.cmd('EslintFixAll')
    else
      vim.lsp.buf.format({
        async = false,
        timeout_ms = 10000,
        filter = allow_format({ 'tsserver', 'solargraph' })
      })
    end

	end)
end

lsp.on_attach(on_attach)


lsp.set_sign_icons({
  error = '✘',
  warn = '▲',
  hint = '⚑',
  info = '»'
})

lsp_config.eslint.setup({
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end,
})

lsp.setup()

require('luasnip.loaders.from_vscode').lazy_load()

cmp.setup({
  sources = {
    {name = 'nvim_lsp'},
    {name = 'luasnip'},
  }
})
