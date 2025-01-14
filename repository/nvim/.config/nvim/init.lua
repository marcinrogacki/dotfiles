-- Set the runtime path
vim.opt.runtimepath:prepend("~/.vim")
vim.opt.runtimepath:append("~/.vim/after")

-- Set the pack path
vim.opt.packpath = vim.opt.runtimepath:get()

-- Source the .vimrc file
vim.cmd("source ~/.vimrc")

-- Plugin: https://github.com/morhetz/gruvbox
-- Tags: appearance
-- Reason: Set the colorscheme
vim.cmd("autocmd vimenter * ++nested colorscheme gruvbox")
vim.g.gruvbox_transparent_bg = 1
-- Fix transparent background https://github.com/morhetz/gruvbox/issues/375
vim.cmd("autocmd VimEnter * hi Normal ctermbg=NONE guibg=NONE")

-- Plugin https://github.com/CopilotC-Nvim/CopilotChat.nvim
-- Tags: git
-- Reason: Enable Github Copilot chat
-- Requirements:
-- * https://github.com/nvim-lua/plenary.nvim (for curl, log and async functions)
-- * https://aur.archlinux.org/packages/lua51-tiktoken-bin
require("CopilotChat").setup {
    -- Nothing to configure yet, just enable it
}

-- -- Plugin https://github.com/neovim/nvim-lspconfig
-- -- Tags: typescript
-- -- Reason: Enable inlay feature
-- -- Used by: coc.nvim
-- -- Requirements: yarn global add typescript typescript-language-server
-- require'lspconfig'.tsserver.setup{
--     init_options = {
--         preferences = {
--             includeInlayParameterNameHints = 'all',
--             includeInlayParameterNameHintsWhenArgumentMatchesName = true,
--             includeInlayFunctionParameterTypeHints = true,
--             includeInlayVariableTypeHints = true,
--             includeInlayPropertyDeclarationTypeHints = true,
--             includeInlayFunctionLikeReturnTypeHints = true,
--             includeInlayEnumMemberValueHints = true,
--             importModuleSpecifierPreference = 'non-relative',
--         },
--     }
-- }
-- -- Toggle inlay hints command
-- vim.api.nvim_create_user_command('ToggleInlayHints',function()
--   vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
-- end,{})
-- ---- The leader key remap for inlay hints
-- --vim.api.nvim_create_autocmd("LspAttach", {
-- --  callback = function(ev)
-- --    local bufnr = ev.buf
-- --    local function get_bufopts(desc)
-- --      return { noremap = true, silent = true, buffer = bufnr, desc = desc }
-- --    end
-- --    map(
-- --      "n",
-- --      "<leader>i",
-- --      "<cmd>ToggleInlayHints<cr>",
-- --      get_bufopts("Toggle LSP Inlay Hint")
-- --    )
-- --  end,
-- --})
