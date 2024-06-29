" Vim syntax file
" Language:     rebar

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syn match     rbrSigil        display contained /\w\+[ \n]/he=e-1,me=e-1
syn match     rbrOperator     display "\%(+\|-\|*\|/\|%\|==\|!=\|>=\|<=\|>\|<\||\|&\)"

syn keyword   rbrKeyword      let if else def

syn match     rbrModName      display "\%(\w\+\):"he=e-1,me=e-1
syn match     rbrDefinition   display "\%(\w\+\)("he=e-1,me=e-1

syn match     rbrDecNumber   display "\<[0-9][0-9_]*"

syn region rbrComment         start="//" end="$"   contains=rbrTodo,@Sperbr

syn keyword rbrTodo contained TODO FIXME XXX NB NOTE SAFETY

hi def link rbrDecNumber       rbrNumber

hi def link rbrKeyword     Keyword
hi def link rbrDefinition  Function
hi def link rbrModName     Identifier
hi def link rbrNumber      Number
hi def link rbrOperator    Operator
hi def link rbrComment     Comment
hi def link rbrTodo        Todo

syn sync minlines=200
syn sync maxlines=500

let b:current_syntax = "rebar"
