-- Set the runtime path
vim.opt.runtimepath:prepend("~/.vim")
vim.opt.runtimepath:append("~/.vim/after")

-- Set the pack path
vim.opt.packpath = vim.opt.runtimepath:get()

-- Source the .vimrc file
vim.cmd("source ~/.vimrc")

--- Plugin: https://github.com/nvim-tree/nvim-tree.lua
--- Reason: Supports ignoring files and directories defined in .gitignore
-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
require("nvim-tree").setup({
    sort = {
        sorter = "case_sensitive",
    },
    view = {
        width = 50,
    },
    filters = {
        git_ignored = true,
        -- Always show those files even when defined in .gitignore
        exclude = {
            ".env",
            ".roy"
        },
    },
    renderer = {
        group_empty = true,
        icons = {
            git_placement = "after",
            glyphs = {
                default = "", -- Normal files
                symlink = "",
                folder = {
                    arrow_closed = ">",
                    arrow_open = "v",
                    default = "",
                    open = "",
                    empty = "",
                    empty_open = "",
                    symlink = "",
                    symlink_open = "",
                },
                git = {
                    unstaged = "!",
                    staged = "+",
                    unmerged = "✗",
                    renamed = "»",
                    deleted = "-",
                    untracked = "?",
                    ignored = "x"
                }
            },
        },

    },
    actions = {
        open_file = {
            window_picker = {
                -- Change from ABC. Used to pick a window from several opened already when opening a file.
                chars = "123456789",
            },
        },
    }
})
-- Open current file in NvimTree
vim.keymap.set("n", "<leader>t", ":NvimTreeFindFileToggle<CR>", { noremap = true, silent = true })

-- Local helper to copy text to X PRIMARY and CLIPBOARD via xclip
local function xclip_echo_copy(text, ok_message)
  if vim.fn.executable("xclip") == 0 then
    vim.notify("xclip not in PATH", vim.log.levels.ERROR)
    return
  end
  -- Turn arbitrary buffer bytes into one shell-safe argument token (handles spaces, newlines, quotes)
  local q = vim.fn.shellescape(text)
  vim.fn.system("echo -n " .. q .. " | xclip -selection primary")
  local err_primary = vim.v.shell_error
  vim.fn.system("echo -n " .. q .. " | xclip -selection clipboard")
  local err_clipboard = vim.v.shell_error
  if err_primary ~= 0 or err_clipboard ~= 0 then
    vim.notify("xclip failed", vim.log.levels.ERROR)
  else
    vim.notify(ok_message, vim.log.levels.INFO)
  end
end

-- A xclip_echo_copy in Normal mode ("n")
vim.keymap.set("n", "<leader>cc", function()
  -- Build one string from the entire current buffer (`\n` between logical lines)
  local text = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n")
  xclip_echo_copy(text, "Buffer copied to primary and clipboard")
  -- noremap: non-recursive mapping so the RHS is never reprocessed as if the user typed another mapping (prevents accidental nested remaps).
  -- silent: do not echo a synthetic command line when the mapping runs (avoids visual noise; `vim.notify` output is unchanged).
  -- desc: label attached to this map for discovery tools (which-key, `vim.keymap.get`, `:map` introspection); not part of runtime behavior.
end, { noremap = true, silent = true, desc = "Copy buffer to xclip (primary+clipboard)" })

-- A xclip_echo_copy in Visual exclusive mode (`x`; not Select mode).
vim.keymap.set("x", "<leader>cc", function()
  -- Preserve register `z` so the copy never clobbers user data stored there.
  local z_save, z_type = vim.fn.getreg("z"), vim.fn.getregtype("z")
  -- Yank the current (live) visual selection into `z`, then leave visual mode with <Esc>.
  -- noautocmd suppresses side-effects; the explicit <Esc> ensures we return to Normal mode.
  vim.cmd([[noautocmd silent normal! "zy]])
  -- `replace_termcodes` converts the "<Esc>" string into the real escape byte sequence.
  -- feedkeys flags: "n" = not remappable (bypasses any user <Esc> mapping), "x" = execute
  -- immediately and synchronously so Normal mode is active before the next line runs.
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "nx", false)
  -- Read back the yanked text; at this point visual mode has exited so `z` is fully written.
  local text = vim.fn.getreg("z")
  -- Restore register `z` to its original value and motion-type metadata.
  vim.fn.setreg("z", z_save, z_type)
  xclip_echo_copy(text, "Selection copied to primary and clipboard")
  -- noremap: non-recursive mapping so the RHS is never reprocessed as if the user typed another mapping (prevents accidental nested remaps).
  -- silent: do not echo a synthetic command line when the mapping runs (avoids visual noise; `vim.notify` output is unchanged).
  -- desc: label attached to this map for discovery tools (which-key, `vim.keymap.get`, `:map` introspection); not part of runtime behavior.
end, { noremap = true, silent = true, desc = "Copy selection to xclip (primary+clipboard)" })

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

-- Create a new :E command that uses custom file opener
vim.api.nvim_create_user_command("E", function(opts)
  require("file_opener").edit_with_position(opts.args)
end, { nargs = 1, complete = "file" })
