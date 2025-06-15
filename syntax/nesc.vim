" Vim syntax file for NESC

" quit when a syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

syn case ignore

syn match nescDecimal     "\<[0-9]\d*\>"           display
syn match nescHexadecimal "\<0[xX][0-9a-fA-F]\+\>" display
syn match nescBinary      "\<0[bB][0-1]\+\>"       display

syn keyword nescTodo          contained TODO FIXME XXX NOTE
syn region nescComment        start="//" end="$" keepend contains=nescTodo,@Spell

syn match nescDelimiter        "(\|)\|\[\|]\|{\|}\|;"  display
syn match nescMathOperator     "+\|-\|*\|&\||\|="   display
syn match nescEqualityOperator "==\|!=\|>\|<"    display
syn keyword nescKeyword        set clear let do while loop if fn volatile addr zeropage
syn keyword nescStart          reset nmi irq

syn match nescFuncCall    "\w\(\w\)*("he=e-1,me=e-1

syn case match

hi def link nescComment       Comment
hi def link nescTodo          Todo

hi def link nescHexadecimal    Number
hi def link nescDecimal        Number
hi def link nescBinary         Number

hi def link nescKeyword          Keyword
hi def link nescStart            Label
hi def link nescDelimiter        Delimiter
hi def link nescMathOperator     Operator
hi def link nescEqualityOperator Label

hi def link nescFuncCall      Function

let b:current_syntax = "nesc"

let &cpo = s:cpo_save
unlet s:cpo_save

" vim: nowrap sw=2 sts=2 ts=8 noet
