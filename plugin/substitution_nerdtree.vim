" shove this in ~/.vim/after/plugin/...
"
" Adds a substitution menu item to nerdtree.
"
" Originally based off grep menuitem written by scrooloose
" (http://gist.github.com/205807)

if exists("g:loaded_nerdtree_substitution_menuitem")
    finish
endif
let g:loaded_nerdtree_substitution_menuitem = 1

call NERDTreeAddMenuItem({
            \ 'text': '(s)ubstitute in folder',
            \ 'shortcut': 's',
            \ 'callback': 'NERDTreeSubstitute' })

function! NERDTreeSubstitute()
    let dirnode = g:NERDTreeDirNode.GetSelected()

    let patternFind = input("Enter the pattern to FIND: ")
    if patternFind == ''
        echo 'Aborted'
        return
    endif

    let patternSubstitute = input("Enter the pattern to SUBSTITUTE with: ")
    if patternSubstitute == ''
        echo 'Aborted'
        return
    endif
    
    "use the previous window to jump to the first search result
    wincmd w

    try
        exec 'silent arg ' . dirnode.path.str() . '/*'
        exec 'argdo %s/' . patternFind . '/' . patternSubstitute . '/gec | update'
    endtry

endfunction
