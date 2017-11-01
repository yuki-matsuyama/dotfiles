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
    call dein#add('Shougo/neocomplcache.vim')
    "スニペットを導入
    call dein#add('Shougo/neosnippet')
    call dein#add('Shougo/neosnippet-snippets')
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
    if has('nvim')
      "deinのプラグイン設定ファイル$HOME/.config/dein/dein.toml
      call dein#load_toml(s:toml_dir . '/denite.toml', {'lazy': 1})
      call dein#load_toml(s:toml_dir . '/denite_plugin.toml', {'lazy': 1})
    else
      call dein#load_toml(s:toml_dir . '/unite.toml')
    endif
    if has('lua')
      call dein#add('Shougo/neocomplete')
      let g:neocomplete#data_directory = g:cache_home . "neocomplete"
      let g:neocomplete#enable_at_startup = 1
      let g:neocomplete#enable_smart_case = 1
      let g:neocomplete#sources#syntax#min_keyword_length = 3
      let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

      let g:neocomplete#sources#dictionary#dictionaries = {
            \ 'default' : '',
            \ 'php' : g:cache_home  . '/dein/repos/github.com/nishigori/vim-php-dictionary/dict/PHP.dict',
            \ }

      " Define keyword.
      if !exists('g:neocomplete#keyword_patterns')
        let g:neocomplete#keyword_patterns = {}
      endif
      let g:neocomplete#keyword_patterns['default'] = '\h\w*'
      " Enable heavy omni completion.
      " if !exists('g:neocomplete#sources#omni#input_patterns')
      "   let g:neocomplete#sources#omni#input_patterns = {}
      " endif
      " if !exists('g:neocomplete#force_omni_input_patterns')
      "   let g:neocomplete#force_omni_input_patterns = {}
      " endif
      " let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\%(\h\w*\)\?\|\h\w*::\%(\h\w*\)\?'
      " let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)\%(\h\w*\)\?'
      " let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\%(\h\w*\)\?\|\h\w*::\%(\h\w*\)\?'
      " let g:neocomplete#sources#omni#input_patterns.perl = '[^. \t]->\%(\h\w*\)\?\|\h\w*::\%(\h\w*\)\?'
      inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
      let g:neocomplete#enable_auto_select = 0
      " <C-h>, <BS>: close popup and delete backword char.
      inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
      inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
      " Enable omni completion.
      " autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
      " autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
      " autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
      " autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
      " autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
      " For perlomni.vim setting.
      " https://github.com/c9s/perlomni.vim
    endif
    if !has('nvim') && !has('lua')
      "conplecache[]'}}}
      let g:acp_enableAtStartup = 0
      " Use neocomplcache.
      let g:neocomplcache_enable_at_startup = 1
      " Use smartcase.
      let g:neocomplcache_enable_smart_case = 1
      " Set minimum syntax keyword length.
      let g:neocomplcache_min_syntax_length = 3
      let g:neocomplcache_temporary_dir = g:cache_home . "/neocomplcache"
      let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

      " Define dictionary.
      let g:neocomplcache_dictionary_filetype_lists = {
            \ 'default' : '',
            \ 'php' : g:cache_home  . '/dein/repos/github.com/nishigori/vim-php-dictionary/dict/PHP.dict',
            \ }
      " Plugin key-mappings.
      inoremap <expr><C-g>     neocomplcache#undo_completion()
      inoremap <expr><C-l>     neocomplcache#complete_common_string()

      " Recommended key-mappings.
      " <CR>: close popup and save indent.
      inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
      function! s:my_cr_function()
        return neocomplcache#smart_close_popup() . "\<CR>"
      endfunction
      " <TAB>: completion.
      inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
      " <C-h>, <BS>: close popup and delete backword char.
      inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
      inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
      inoremap <expr><C-y>  neocomplcache#close_popup()
      inoremap <expr><C-e>  neocomplcache#cancel_popup()
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
" let g:deoplete#enable_at_startup = 1
"unite
 if executable('ag')
   let g:unite_source_grep_command = 'ag'
   let g:unite_source_grep_default_opts = '--nocolor --nogroup'
   let g:unite_source_grep_max_candidates = 200
   let g:unite_source_grep_recursive_opt = ''
 endif

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

"easy motionの設定
" nmap  / <Plug>(easymotion-sn)
" omap / <Plug>(easymotion-tn)

" vimshell 設定
" let g:vimshell_user_prompt = 'fnamemodify(getcwd(), ":~")'
" nnoremap <silent> <C-u><C-t> :<C-u>VimShell<CR>

"nerdtree設定
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
let NERDTreeShowHidden=1
let g:nerdtree_tabs_open_on_console_startup = 1
let g:NERDTreeMapOpenInTab = "o"
let g:NERDTreeMapActivateNode = "l"
let g:NERDTreeMapDeActivateNode = "h"
nnoremap <silent> <Leader>v :<C-u>NERDTreeToggle<CR>

"openbrowser
nmap <Leader>o <Plug>(openbrowser-smart-search)
vmap <Leader>o <Plug>(openbrowser-smart-search)

"airlineの設定
" タブバーのカスタマイズを有効にする
" let g:airline#extensions#tabline#enabled = 1

" タブバーの右領域を非表示にする
" let g:airline#extensions#tabline#show_splits = 0
" let g:airline#extensions#tabline#show_tab_type = 0
" let g:airline#extensions#tabline#show_close_button = 0
let g:airline_section_c = airline#section#create(['path'])
" let g:airline#extensions#tabline#fnamemod = ':t'


"vimfilerの設定
" let g:vimfiler_as_default_explorer  = 1
" let g:vimfiler_safe_mode_by_default = 0
" let g:vimfiler_data_directory       = expand('~/.vim/etc/vimfiler')
" nnoremap <silent> <Leader>v :<C-u>VimFilerExplorer<CR>
" nnoremap <Leader>v :NERDTreeToggle<CR>


imap <C-e>, <plug>(emmet-expand-abbr)

"key map個人
"highlight CursorLine term=reverse cterm=reverse
set background=dark
" autocmd colorscheme antares highlight Visual ctermbg=8
colorscheme antares
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



"}}}
" unite.vim"{{{

"ctrlp設定
" CtrlPのウィンドウ最大高さ
let g:ctrlp_max_height = 30
" 無視するディレクトリ
let g:ctrlp_custom_ignore = {
\ 'dir':  '\v[\/](\.git|node_modules)$',
\ 'file': '\v\.(exe|so|dll)$',
\ 'link': 'some_bad_symbolic_links',
\ }
let g:ctrlp_types = ['mru', 'fil']
let g:ctrlp_show_hidden = 1
let g:ctrlp_lazy_update = 1
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_map = '<c-u><c-u>'
let g:ctrlp_prompt_mappings = {
  \ 'PrtBS()':              ['<bs>', '<c-]>'],
  \ 'PrtDeleteWord()':      ['<c-w>'],
  \ 'PrtClear()':           ['<c-u>'],
  \ 'PrtSelectMove("j")':   ['<c-n>', '<down>'],
  \ 'PrtSelectMove("k")':   ['<c-p>', '<up>'],
  \ 'PrtHistory(-1)':       ['<c-j>'],
  \ 'PrtHistory(1)':        ['<c-k>'],
  \ 'ToggleRegex()':        ['<c-r>'],
  \ }
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

"neocomplete-php
" let g:neocomplete_php_locale = 'ja'
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

" Enable snipMate compatibility feature.

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
let g:neosnippet#enable_snipmate_compatibility = 1
" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory= '~/.config/dein/neosnippet'
" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

autocmd VimEnter * NeoComplCacheEnable " Enable NeoComplete at startup"
" autocmd VimEnter * NeoCompleteEnable " Enable NeoComplete at startup"
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
