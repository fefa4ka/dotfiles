-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- nvim-cmp setup
local cmp = require('cmp')

-- luasnip setup
local luasnip = require('luasnip')

-- lspconfig setup
local lspconfig = require('lspconfig')

-- The nvim-cmp almost supports LSP's capabilities so You should
-- advertise it to LSP servers..
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

cmp.setup {
  completion = {
    keyword_length = 1,
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.complete(),

    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),

    ['<space>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
	    cmp.close()
	  else
	    fallback()
	  end
    end, { "i", "s" }),

    ['<cr>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
  },
  sources = {
    { name = 'cmp_tabnine' },
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
  },
}

-- Enable some language servers with the additional completion capabilities
-- offered by nvim-cmp
-- LSP list:
--   ccls -> c/c++
--   rust_analyzer -> rust
--   pyright -> python
--   tsserver -> typescript
-- local servers = { 'ccls', 'rust_analyzer', 'pyright', 'tsserver' }
-- for _, lsp in ipairs(servers) do
--   lspconfig[lsp].setup {
--     -- on_attach = my_custom_on_attach,
--     capabilities = capabilities,
--   }
-- end
