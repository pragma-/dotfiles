set tabstop=4
set sw=4
set expandtab
set laststatus=2
set nu
set signcolumn=yes
set updatetime=300
set cmdheight=2

" vim-plug
call plug#begin()
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/cmp-emoji'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'simrat39/rust-tools.nvim'
Plug 'catppuccin/nvim', {'as': 'catppuccin'}
Plug 'nvim-lualine/lualine.nvim'
Plug 'junegunn/vim-easy-align'
Plug 'kdheepak/cmp-latex-symbols'
call plug#end()

" turn on indentation
filetype plugin indent on

" return to last known position when opening file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" strip trailing whitespace when saving
autocmd BufWritePre * %s/\s\+$//e

" time-stamped backups
set backup
execute "set backupext=_" . strftime("%Y-%m-%d-%H:%M:%S~")

" `cpanfile` is a Perl file
au BufRead,BufNewFile cpanfile set filetype=perl

" aliases
:command Lsplog lua vim.cmd('edit '..vim.lsp.get_log_path())

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Configure LSP code navigation shortcuts as found in :help lsp
nnoremap <silent> <c-]>     <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> <c-k>     <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> K         <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gi        <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> gc        <cmd>lua vim.lsp.buf.incoming_calls()<CR>
nnoremap <silent> gd        <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr        <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gn        <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> gs        <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gw        <cmd>lua vim.lsp.buf.workspace_symbol()<CR>

lua <<END
-- lsp capabilities
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- rust-analyzer lsp
require('lspconfig').rust_analyzer.setup {
    capabilities = capabilities,
}

-- code-completion
-- https://github.com/hrsh7th/nvim-cmp#recommended-configuration
local cmp = require('cmp')
cmp.setup({
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'path' },
    { name = 'buffer' },
    { name = 'nvim_lsp_signature_help' },
    { name = 'latex_symbols' },
    { name = 'emoji' },
  },
})

-- rust-tools
require('rust-tools').setup({
    tools = {
        inlay_hints = {
            show_variable_name = true,
        },
    },
})

-- lualine
require('lualine').setup()
END

" pretty colors
let g:catppuccin_flavour = "mocha" " latte, frappe, macchiato, mocha
colorscheme catppuccin
