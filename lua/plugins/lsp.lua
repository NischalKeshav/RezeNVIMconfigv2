return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "b0o/schemastore.nvim",
  },
  opts = function()
    return {
      servers = {
        lua_ls = {},
        ts_ls = {},
        pyright = {},
        rust_analyzer = {},
        gopls = {},
        zls = {},
        clangd = {},
        jsonls = {
          settings = {
            json = {
              schemas = require('schemastore').json.schemas(),
              validate = { enable = true },
            },
          },
        },
        ['*'] = {
          keys = {
            { "H", "<cmd>echo 'hello'<cr>", desc = "Say Hello" },
            { "K", "<cmd>echo 'custom hover'<cr>", desc = "Custom Hover" },
            { "gd", false },
	    { "<leader>mg", vim.diagnostic.open_float, desc = "Show line diagnostics" },
          },
        },
      },
    }
  end,
  config = function(_, opts)
    -- Set up keymaps for all LSP servers
    if opts.servers['*'] and opts.servers['*'].keys then
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local bufnr = args.buf
          for _, key in ipairs(opts.servers['*'].keys) do
            if key[2] ~= false then
              vim.keymap.set('n', key[1], key[2], { buffer = bufnr, desc = key.desc })
            end
          end
        end,
      })
    end
    
    -- Configure each language server using the new API
    for server, config in pairs(opts.servers) do
      if server ~= '*' then
        -- Use vim.lsp.config for Neovim 0.11+
        vim.lsp.config(server, vim.tbl_deep_extend("force", {
          root_dir = vim.fs.root(0, {'.git'}),
        }, config))
        
        -- Enable the language server
        vim.lsp.enable(server)
      end
    end
  end,
}
