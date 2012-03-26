" Chargement de Pathogen
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" Activation de l'indentation automatique
set autoindent
" Redéfinition des tabulations
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=8
" Activation de la détection automatique du type de fichier
filetype on
filetype plugin indent on

" Longueur maximale des lignes
set textwidth=79

" Activation de la coloration syntaxique
syntax on

" Lecture des raccourcis clavier généraux
execute 'source ' . $HOME . '/.vim/shortkeys.vim'

" Activation de la barre de status de fugitive
set laststatus=2
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [Line=%04l]\ [Col=%04v]\ [%p%%]\ %{fugitive#statusline()}

" Fonction d'affichage d'un message en inverse vidéo
function! s:DisplayStatus(msg)
    echohl Todo
    echo a:msg
    echohl None
endfunction

" Variable d'enregistrement de l'état de la gestion de la souris
let s:mouseActivation = 1
" Fonction permettant l'activation/désactivation de la gestion de la souris
function! ToggleMouseActivation()
    if (s:mouseActivation)
        let s:mouseActivation = 0
        set mouse=n
        set paste
        call s:DisplayStatus('Désactivation de la gestion de la souris (mode collage)')
    else
        let s:mouseActivation = 1
        set mouse=a
        set nopaste
        call s:DisplayStatus('Activation de la gestion de la souris (mode normal)')
    endif
endfunction

" Activation par défaut au démarrage de la gestion de la souris
set mouse=a
set nopaste

" Fonction de 'nettoyage' d'un fichier
"   - remplacement des tabulations par des espaces
"   - suppression des caractères ^M en fin de ligne
function! CleanCode()
    %retab
    %s/^M//g
    call s:DisplayStatus('Code nettoyé')
endfunction

" Affichage des numéros de ligne
set number
highlight LineNr ctermbg=blue ctermfg=gray

" Surligne la colonne du dernier caractère autorisé par textwidth
set cc=+1

" Ouverture des fichiers avec le curseur à la position de la dernière édition
function! s:CursorOldPosition()
  if line("'\"") > 0 && line("'\"") <= line("$")
    exe "normal g`\""
  endif
endfunction
autocmd BufReadPost * silent! call s:CursorOldPosition()

" Ajout d'une ligne colorée pour surligner la ligne en cours
set cursorline
highlight CursorLine term=reverse cterm=reverse
" Amélioration de la lisibilité des noms des onglets
highlight TabLine term=none cterm=none
highlight TabLineSel ctermbg=darkblue

" Modification du modèle de coloration syntaxique
set background=dark
colorscheme solarized

if !filewritable($HOME."/.vim/backup") " Si le repertoire n'existe pas
    call mkdir($HOME."/.vim/backup", "p") " Creation du repertoire de sauvegarde
endif
set backupdir=$HOME/.vim/backup " On definit le repertoire de sauvegarde
set backup " On active le comportement

runtime macros/matchit.vim

augroup myfiletypes
  autocmd!
  autocmd FileType ruby,eruby,yaml set ai sw=2 sts=2 et
augroup END

set nocompatible

if has("autocmd")
  filetype indent plugin on
endif
