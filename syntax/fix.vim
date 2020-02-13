if exists("b:current_syntax")
  finish
endif

let s:keepcpo= &cpo
set cpo&vim

syn clear

" Conceal the tag separator
syn match fixSep "" contained conceal cchar= 
" A fix tag is one or more digits before =
syn match fixTagID "\d\+="me=e-1 contained contains=fixSep
" A tag value is after = up to the next separator. In vim .* non-greedy is .\{-}
syn match fixTagValue "=.\{-}"ms=s+1,me=e-1 contained contains=fixSep
" Match the text field
syn match fixText "58=.\{-}"hs=s+3 contained contains=fixSep
" Match the to various tags that we want to minimise
syn match fixSenderCompID "49=.\{-}"hs=s+3 contained contains=fixSep
syn match fixTargetCompID "56=.\{-}"hs=s+3 contained contains=fixSep
syn match fixMsgSeqNum "34=.\{-}"hs=s+3 contained contains=fixSep
syn match fixSendingTime "52=.\{-}"hs=s+3 contained contains=fixSep
" The Symbol
syn match fixSymbol "55=.\{-}"hs=s+3 contained contains=fixSep
" Client order ID
syn match fixClOrdID "11=.\{-}"hs=s+3 contained contains=fixSep
" A Fix tag
syn match fixTag "\d\+=.\{-}"me=e-1 contained contains=fixSep,fixTagID,fixTagValue,fixText,fixSenderCompID,fixTargetCompID,fixMsgSeqNum,fixSendingTime,fixSymbol,fixClOrdID
" The header is the first two fields
syn region fixHeader start="^8" end="\v9\=\d+" oneline contains=fixSep
" The next region is the body up to but excluding the checksum tag. me is used
" to reduce the match length to prevent it overlapping the fixTail group
syn region fixBody start="35=" end="10="me=e-4,re=e-3  oneline contains=fixSep,fixTag
" The end of the message is the checksum
syn region fixTail start="10=" end="$" oneline contains=fixSep

" Function called when there is a change in the current colorscheme
function! SetFixColors()
	hi def link fixTagID Keyword
	hi def link fixTagValue String
	hi def link fixTag Comment
	hi def link fixHeader NonText
	hi def link fixBody Comment
	hi def link fixTail NonText
	hi def link fixText Todo
	hi def link fixSenderCompID Comment 
	hi def link fixTargetCompID Comment 
	hi def link fixMsgSeqNum Comment 
	hi def link fixSendingTime Special 
	hi def link fixSymbol Identifier 
	hi def link fixClOrdID PreProc 
endfunction

call SetFixColors()
let b:current_syntax = "fix"

let &cpo = s:keepcpo
unlet s:keepcpo
