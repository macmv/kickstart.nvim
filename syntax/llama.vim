" Vim syntax file
" Language:     llama

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syn match     llSigil        display contained /\w\+[ \n]/he=e-1,me=e-1
syn match     llOperator     display "\%(==\)"
syn match     llLayerName    display "layer \%(\w\+\)"hs=s+6,ms=s+6

syn keyword   llKeyword      repeat

syn match     llModName      display "\%(\w\+\):"he=e-1,me=e-1
syn match     llDefinition   display "^\%(\w\+\):"he=e-1,me=e-1

syn region llComment         start="#" end="$"   contains=llTodo,@Spell

syn keyword llTodo contained TODO FIXME XXX NB NOTE SAFETY

hi def link llKeyword     Keyword
hi def link llDefinition  Function
hi def link llModName     Identifier
hi def link llLayerName   Operator
hi def link llOperator    Operator
hi def link llComment     Comment
hi def link llTodo        Todo

syn sync minlines=200
syn sync maxlines=500

let b:current_syntax = "llama"
