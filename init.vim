let g:python3_host_prog = expand('$HOME') . '/.pyenv/shims/python'
let g:cache_home = empty($XDG_CACHE_HOME) ? expand('$HOME/.cache') : $XDG_CACHE_HOME
let g:config_home = empty($XDG_CONFIG_HOME) ? expand('$HOME/.config') : $XDG_CONFIG_HOME

" deinのホームディレクトリを$HOME/.cache/dein
let s:dein_cache_dir = g:cache_home . '/dein'

" reset augroup
augroup MyAutoCmd
    autocmd!
augroup END

if &runtimepath !~# '/dein.vim'
    "dein自体もpluginとしてdein配下に入れる
    let s:dein_repo_dir = s:dein_cache_dir . '/repos/github.com/Shougo/dein.vim'
    " Auto Download
    if !isdirectory(s:dein_repo_dir)
        call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
    endif
    " dein.vim をプラグインとして読み込む
    execute 'set runtimepath^=' . s:dein_repo_dir
endif
if dein#load_state(s:dein_cache_dir)
    call dein#begin(s:dein_cache_dir)
    let s:toml_dir = g:config_home . '/dein'
    "共通プラグイン
    call dein#load_toml(s:toml_dir . '/common.toml')
    call dein#add( 'leafgarland/typescript-vim', {
                \ 'autoload' :{
                \   'filetypes': ['typescript']
                \ }
                \})
    call dein#add('thinca/vim-quickrun')
    call dein#add('y-matsuyama/vim-php-cs-fixer')
    call dein#add('ctrlpvim/ctrlp.vim')
    call dein#add('Quramy/tsuquyomi')
    " call dein#add('nishigori/vim-php-dictionary', {'on_ft': 'php', 'rev': 'php7.1'})
    call dein#add('ekalinin/Dockerfile.vim')
    call dein#add('evidens/vim-twig')
    call dein#add('scrooloose/nerdtree')
    call dein#add('posva/vim-vue')
    call dein#add('heavenshell/vim-jsdoc')
    call dein#add('bronson/vim-trailing-whitespace')
    call dein#add('vim-scripts/PDV--phpDocumentor-for-Vim')
    call dein#add('w0ng/vim-hybrid')
    call dein#add('Shougo/deoppet.nvim')
    call dein#add('Shougo/deoplete.nvim')
    call dein#add('Shougo/denite.nvim')
    call dein#add('lvht/phpcd.vim')
    nmap [denite] <Nop>
    map <C-j> [denite]

    " プロジェクト内のファイル検索
    nmap <silent> [denite]<C-u> :<C-u>Denite file_rec -highlight-mode-insert=Search<CR>
    " バッファに展開中のファイル検索
    nmap <silent> [denite]<C-l> :<C-u>Denite buffer -highlight-mode-insert=Search<CR>
    " ファイル内の関数/クラス等の検索
    nmap <silent> [denite]<C-o> :<C-u>Denite outline -highlight-mode-insert=Search<CR>
    " dotfiles配下をカレントにしてfile_rec起動
    nmap <silent> [denite]<C-v> :<C-u>call denite#start([{'name': 'file_rec', 'args': ['~/.dotfiles']}]) -highlight-mode-insert=Search=Search<CR>

    " 上下移動を<C-N>, <C-P>
    call denite#custom#map('normal', '<C-N>', '<denite:move_to_next_line>')
    call denite#custom#map('normal', '<C-P>', '<denite:move_to_previous_line>')
    call denite#custom#map('insert', '<C-N>', '<denite:move_to_next_line>')
    call denite#custom#map('insert', '<C-P>', '<denite:move_to_previous_line>')
    " 入力履歴移動を<C-J>, <C-K>
    call denite#custom#map('insert', '<C-J>', '<denite:assign_next_text>')
    call denite#custom#map('insert', '<C-K>', '<denite:assign_previous_text>')
    " 横割りオープンを`<C-S>`
    call denite#custom#map('insert', '<C-S>', '<denite:do_action:split>')
    " 縦割りオープンを`<C-I>`
    call denite#custom#map('insert', '<C-I>', '<denite:do_action:vsplit>')
    " タブオープンを`<C-O>`
    call denite#custom#map('insert', '<C-O>', '<denite:do_action:tabopen>')

    " file_rec検索時にfuzzymatchを有効にし、検索対象から指定のファイルを除外
    call denite#custom#source(
                \ 'file_rec', 'matchers', ['matcher_fuzzy', 'matcher_project_files', 'matcher_ignore_globs'])

    " 検索対象外のファイル指定
    call denite#custom#filter('matcher_ignore_globs', 'ignore_globs',
                \ [ '.git/', '.ropeproject/', '__pycache__/',
                \   'venv/', 'images/', '*.min.*', 'img/', 'fonts/'])
    call dein#add('Shougo/deol.nvim')
    if !has('nvim')
        call dein#add('roxma/nvim-yarp')
        call dein#add('roxma/vim-hug-neovim-rpc')
    endif
    call dein#end()
    call dein#save_state()
endif
if has('vim_starting') && dein#check_install()
    call dein#install()
endif

syntax on
filetype plugin indent  on
set wildmenu
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
set history=1000
set modifiable
set write
set wrap
set confirm
set clipboard=unnamed
set modelines=0
set tabstop=4
set shiftwidth=4
set expandtab
set number
set ruler
set laststatus=2
set showcmd
set noswapfile
" set incsearch
set ignorecase
set title
set noshowmode
set autoindent
set smartindent
set conceallevel=0
" set completeopt+=noinsert "vimの保管をinsertで始めるかselectで始めるかの設定が存在す"
" set completeopt+=noselect
set completeopt+=noinsert
" set list
" set listchars=tab:>.,trail:.,extends:>,precedes:<,nbsp:%
set directory=~/.vim/
set undodir=~/.vim/
set backspace=indent,eol,start
set hlsearch
"deocompleteの設定
"indent の高速化
let g:indentLine_faster = 1

"git gutterの設定
function! MyGitGutter()
    if ! exists('*GitGutterGetHunkSummary')
                \ || ! get(g:, 'gitgutter_enabled', 0)
                \ || winwidth('.') <= 90
        return ''
    endif
    let symbols = [
                \ g:gitgutter_sign_added . ' ',
                \ g:gitgutter_sign_modified . ' ',
                \ g:gitgutter_sign_removed . ' '
                \ ]
    let hunks = GitGutterGetHunkSummary()
    let ret = []
    for i in [0, 1, 2]
        if hunks[i] > 0
            call add(ret, symbols[i] . hunks[i])
        endif
    endfor
    return join(ret, ' ')
endfunction
imap <C-e>, <plug>(emmet-expand-abbr)

"key map個人
"highlight CursorLine term=reverse cterm=reverse
" autocmd colorscheme antares highlight Visual ctermbg=8
if $ENV == 'local'
    set background=dark
    colorscheme hybrid
elseif $ENV == 'unit'
    colorscheme antares
endif
autocmd InsertEnter * set cursorline
autocmd InsertLeave * set nocursorline

"plugin 用のkey map
nnoremap gs :Gstatus<CR>
nnoremap ga :Gwrite<CR>
nnoremap gco :Gcommit<CR>
nnoremap gd :Gdiff<CR>
nnoremap gb :Gblame<CR>

inoremap <C-l> <Right>
inoremap <C-h> <Left>
nnoremap <C-t> :tabnew<CR>

"php fixer
" If you use php-cs-fixer version 2.x
let g:php_cs_fixer_rules = "@PSR2"          " options: --rules (default:@PSR2)
" let g:php_cs_fixer_cache = ".php_cs.cache" " options: --cache-file
let g:php_cs_fixer_config_file = $HOME . '/dotfile/.php_cs' " options: --config
" End of php-cs-fixer version 2 config params

let g:php_cs_fixer_php_path = "php"               " Path to PHP
" let g:php_cs_fixer_enable_default_mapping = 1     " Enable the mapping by default (<leader>pcd)
let g:php_cs_fixer_dry_run = 1                    " Call command with dry-run option
let g:php_cs_fixer_verbose = 1                    " Return the output of command if 1, else an inline information.
" nnoremap <silent><leader>php :call PhpCsFixerFixDirectory()<CR>
nnoremap <silent><leader>php :call PhpCsFixerFixFile()<CR>

"" vim-quickrun {{{
function! EslintFix() abort "{{{
    let l:quickrun_config_backup                  = g:quickrun_config['javascript']
    let g:quickrun_config['javascript']['cmdopt'] = l:quickrun_config_backup['cmdopt'] .' --config '. $HOME .'/dotfile/.eslintrc --fix'
    let g:quickrun_config['javascript']['runner'] = 'system'

    QuickRun

    let g:quickrun_config['javascript'] = l:quickrun_config_backup
endfunction "}}}
nnoremap <Leader>es   :<C-u>call<Space>EslintFix()<CR>
let s:quickrun_config_javascript = {
            \    'command':     'eslint',
            \    'cmdopt':      '--cache --cache-location ' . s:dein_cache_dir . '/eslint/.eslintcache --format compact --max-warnings 1 --no-color --no-ignore --quiet',
            \    'errorformat': '%E%f: line %l\, col %c\, Error - %m,%W%f: line %l\, col %c\, Warning - %m,%-G%.%#',
            \    'exec':        '%c %o %s:p'
            \}
let g:quickrun_config = {
            \    '_': {
            \        'hook/close_buffer/enable_empty_data': 1,
            \        'hook/close_buffer/enable_failure':    1,
            \        'outputter':                           'multi:buffer:quickfix',
            \        'outputter/buffer/close_on_empty':     1,
            \        'outputter/buffer/split':              ':botright',
            \        'runner':                              'vimproc',
            \        'runner/vimproc/updatetime':           600
            \    },
            \    'javascript': {
            \        'command':     s:quickrun_config_javascript['command'],
            \        'cmdopt':      s:quickrun_config_javascript['cmdopt'] . ' --config ' . $HOME . '/dotfile/.eslintrc',
            \        'errorformat': s:quickrun_config_javascript['errorformat'],
            \        'exec':        s:quickrun_config_javascript['exec']
            \    }
            \}
"filetype set
augroup Vimrc
    autocmd!
    autocmd BufNewFile,BufRead *.jsx set filetype=javascript.jsx
augroup END

if has('conceal')
    set conceallevel=2 concealcursor=niv
endif

autocmd BufRead,BufNewFile *.vue setlocal filetype=vue.html.javascript.css
autocmd BufWritePre * :%s/\s\+$//ge
function! ZenkakuSpace()
    highlight ZenkakuSpace cterm=reverse ctermfg=DarkMagenta gui=reverse guifg=DarkMagenta
endfunction

function! UnintentionalComment()
    highlight UnintentionalComment cterm=reverse ctermfg=DarkMagenta gui=reverse guifg=DarkMagenta
endfunction

if has('syntax')
    augroup ZenkakuSpace
        autocmd!
        autocmd ColorScheme       * call ZenkakuSpace()
        autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
    augroup END
    call ZenkakuSpace()
endif

augroup UnintentionalCommentHighlight
    autocmd!
    autocmd ColorScheme       * call UnintentionalComment()
    autocmd VimEnter,WinEnter * match UnintentionalComment /\/\/.*private/
augroup END
call UnintentionalComment()
nnoremap <Leader>pd :call PhpDocSingle()<CR>
