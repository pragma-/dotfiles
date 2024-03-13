set tabstop=4           " number of spaces that a tab counts for
set shiftwidth=4        " number of spaces per indentation
set expandtab           " insert spaces instead of tabs
set laststatus=2        " last window always has a status line
set number              " show line numbers
set signcolumn=yes      " show sign column for LSP indicators
set updatetime=300      " idle time in milliseconds before swap is written
set cmdheight=1         " number of screen lines to use for command-line
set jumpoptions+=stack  " make jumplist behave like tag stack
set mouse=              " disable mouse actions
set termguicolors       " fancy colors

" vim-plug
" vim:  curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" nvim: curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" then run `:PlugInstall`
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
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- rust-analyzer lsp
require('lspconfig').rust_analyzer.setup {
    capabilities = capabilities,
}

-- clangd lsp
require('lspconfig').clangd.setup {
    capabilities = capabilities,
}

-- pls perl lsp
require'lspconfig'.perlpls.setup {
    capabilities = capabilities,
    settings = {
        perl = {
            inc = { '$HOME/perl5/lib', '$ROOT_PATH/lib' },
        },
    },
}

-- code-completion
-- https://github.com/hrsh7th/nvim-cmp#recommended-configuration
local cmp = require('cmp')
cmp.setup {
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
}

-- rust-tools
require('rust-tools').setup {
    tools = {
        inlay_hints = {
            show_variable_name = true,
        },
    },
}

-- lualine
require('lualine').setup()

-- catppuccin colors
require('catppuccin').setup {
    color_overrides = {
        mocha = {
--           Latte       Frappe      Macchiato   Mocha
--rosewater  #dc8a78     #F2D5CF     #F4DBD6     #F5E0DC     Winbar
--flamingo   #DD7878     #EEBEBE     #F0C6C6     #F2CDCD     Target word
--pink       #ea76cb     #F4B8E4     #F5BDE6     #F5C2E7     Just pink
--mauve      #8839EF     #CA9EE6     #C6A0F6     #CBA6F7     Tag
--red        #D20F39     #E78284     #ED8796     #F38BA8     Error
--maroon     #E64553     #EA999C     #EE99A0     #EBA0AC     Lighter red
--peach      #FE640B     #EF9F76     #F5A97F     #FAB387     Number
--yellow     #df8e1d     #E5C890     #EED49F     #F9E2AF     Warning
--green      #40A02B     #A6D189     #A6DA95     #A6E3A1     Diff add
--teal       #179299     #81C8BE     #8BD5CA     #94E2D5     Hint
--sky        #04A5E5     #99D1DB     #91D7E3     #89DCEB     Operator
--sapphire   #209FB5     #85C1DC     #7DC4E4     #74C7EC     Constructor
--blue       #1e66f5     #8CAAEE     #8AADF4     #89B4FA     Diff changed
--lavender   #7287FD     #BABBF1     #B7BDF8     #B4BEFE     CursorLine Nr
--text       #4C4F69     #c6d0f5     #CAD3F5     #CDD6F4     Default fg
--subtext1   #5C5F77     #b5bfe2     #B8C0E0     #BAC2DE     Indicator
--subtext0   #6C6F85     #a5adce     #A5ADCB     #A6ADC8     Float title
--overlay2   #7C7F93     #949cbb     #939AB7     #9399B2     Popup fg
--overlay1   #8C8FA1     #838ba7     #8087A2     #7F849C     Conceal color
--overlay0   #9CA0B0     #737994     #6E738D     #6C7086     Fold color
--surface2   #ACB0BE     #626880     #5B6078     #585B70     Default comment
            surface2 = "#8585A0",
--surface1   #BCC0CC     #51576d     #494D64     #45475A     Darker comment
--surface0   #CCD0DA     #414559     #363A4F     #313244     Darkest comment
--base       #EFF1F5     #303446     #24273A     #1E1E2E     Default bg
--mantle     #E6E9EF     #292C3C     #1E2030     #181825     Darker bg
--crust      #DCE0E8     #232634     #181926     #11111B     Darkest bg
        },
    },
}

END

" pretty colors
let g:catppuccin_flavour = "mocha" " latte, frappe, macchiato, mocha
colorscheme catppuccin
