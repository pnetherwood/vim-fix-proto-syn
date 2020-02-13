if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

let s:keepcpo= &cpo
set cpo&vim

function! FoldHeartbeats(lnum)
  if get(split(getline(a:lnum),''),2,'')=='35=0'
    return 1
  endif

  if get(split(getline(a:lnum-1),''),2,'')=='35=0' && get(split(getline(a:lnum),''),2,'')!='35=0'
    return '<1'
  endif

  return 0
endfunction

function! MyFoldText()
    let nl = v:foldend - v:foldstart + 1
    let txt = '+ ' . nl . ' heartbeats'
    return txt
endfunction
setlocal foldtext=MyFoldText()

" Wrap long messages
setlocal wrap
" Line break in between tags
setlocal breakat=
" Fold heatbeat messages
setlocal foldmethod=expr
setlocal foldexpr=FoldHeartbeats(v:lnum)
setlocal foldlevel=0
setlocal foldlevelstart=0
" Hide the tag separator as specified in the signal file
setlocal conceallevel=1
" Conceal in normal mode
setlocal concealcursor=n
" Keep syntax highlighting for long lines
setlocal synmaxcol=1000

let &cpo = s:keepcpo
unlet s:keepcpo
