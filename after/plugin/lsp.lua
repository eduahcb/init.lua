local lsp = require('lsp-zero')

lsp.preset("recommended")

local function allow_format(servers)
  return function(client) return vim.tbl_contains(servers, client.name) end
end


lsp.ensure_installed({
  'tsserver',
  "eslint",
  "lua_ls",
  "html"
})


local on_attach = function(client, bufnr)
	lsp.default_keymaps({buffer = bufnr})

	vim.keymap.set("n", "<leader>lf", function()
		vim.lsp.buf.format({
			async = false,
			timeout_ms = 10000,
			filter = allow_format({ 'tsserver', 'eslint' })}
		)
	end)
end

lsp.on_attach(on_attach)


lsp.set_sign_icons({
  error = '✘',
  warn = '▲',
  hint = '⚑',
  info = '»'
})

lsp.format_on_save({
	format_opts = {
		timeout_ms = 10000,
	},
	servers = {
		['null-ls'] = {'javascript', 'typescript', 'javascriptreact', 'typescriptreact'},
	}
})

lsp.setup()


local null_ls = require("null-ls")

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local formatting = null_ls.builtins.formatting
local code_actions = null_ls.builtins.code_actions

null_ls.setup({
  sources = {
    formatting.eslint_d,
    code_actions.eslint_d,

    formatting.prettier,
  },
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                    vim.lsp.buf.formatting_sync()
                end,
            })
        end
    end,
})
