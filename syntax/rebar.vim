" Vim syntax file
" Language:     rebar

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syn match     rbrSigil        display contained /\w\+[ \n]/he=e-1,me=e-1
syn match     rbrOperator     display "\%(+\|-\|*\|/\|%\|==\|!=\|>=\|<=\|>\|<\||\|&\|as\)"

syn match     rbrEscapeError        display contained /\\./
syn match     rbrEscape             display contained /\\\([nrt0\\'"]\|x\x\{2}\)/
syn match     rbrEscapeUnicode      display contained /\\u{\%(\x_*\)\{1,6}}/
syn match     rbrStringContinuation display contained /\\\n\s*/
syn region    rbrString             matchgroup=rbrStringDelimiter start=+b"+ skip=+\\\\\|\\"+ end=+"+ contains=rbrEscape,rbrEscapeError,rbrStringContinuation
syn region    rbrString             matchgroup=rbrStringDelimiter start=+"+ skip=+\\\\\|\\"+ end=+"+ contains=rbrEscape,rbrEscapeUnicode,rbrEscapeError,rbrStringContinuation,@Spell
syn region    rbrString             matchgroup=rbrStringDelimiter start='b\?r\z(#*\)"' end='"\z1' contains=@Spell

syn keyword   rbrKeyword      struct trait impl let if else fn

syn match     rbrModName      display "\%(\w\+\):"he=e-1,me=e-1
syn match     rbrDefinition   display "\%(\w\+\)("he=e-1,me=e-1

syn match     rbrDecNumber   display "\<[0-9][0-9_]*"

syn region rbrComment         start="//" end="$"   contains=rbrTodo,@Sperbr

syn keyword rbrTodo contained TODO FIXME XXX NB NOTE SAFETY

hi def link rbrDecNumber       rbrNumber

hi def link rbrKeyword         Keyword
hi def link rbrString          String
hi def link rbrStringDelimiter String
hi def link rbrEscape          Special
hi def link rbrEscapeUnicode   rbrEscape
hi def link rbrEscapeError     Error
hi def link rbrDefinition      Function
hi def link rbrModName         Identifier
hi def link rbrNumber          Number
hi def link rbrOperator        Operator
hi def link rbrComment         Comment
hi def link rbrTodo            Todo

syn sync minlines=200
syn sync maxlines=500

let b:current_syntax = "rebar"
