" Vim syntax file
" Language:     rebar

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syn match     rbrSigil        display contained /\w\+[ \n]/he=e-1,me=e-1
syn match     rbrOperator     display "\%(=>\|??\|+\|-\|*\|/\|%\|==\|!=\|>=\|<=\|>\|<\||\|&\|?\|!\)"
syn keyword   rbrOperator     as chop clamp

syn match     rbrEscapeError        display contained /\\./
syn match     rbrEscape             display contained /\\\([nrt0\\'"]\|x\x\{2}\)/
syn match     rbrEscapeUnicode      display contained /\\u{\%(\x_*\)\{1,6}}/
syn match     rbrStringContinuation display contained /\\\n\s*/
syn region    rbrString             matchgroup=rbrStringDelimiter start=+b"+ skip=+\\\\\|\\"+ end=+"+ contains=rbrEscape,rbrEscapeError,rbrStringContinuation
syn region    rbrInterpolation      matchgroup=rbrInterpolationDelimiter start="#{" end="}" contained contains=TOP
syn region    rbrString             matchgroup=rbrStringDelimiter start=+"+ skip=+\\\\\|\\"+ end=+"+ contains=rbrEscape,rbrEscapeUnicode,rbrEscapeError,rbrStringContinuation,rbrInterpolation,@Spell
syn region    rbrString             matchgroup=rbrStringDelimiter start='b\?r\z(#*\)"' end='"\z1' contains=@Spell
syn region    rbrChar               matchgroup=rbrCharDelimiter start=+'+ skip=+\\\\\|\\'+ end=+'+ contains=rbrEscape,rbrEscapeUnicode,rbrEscapeError

syn match     rbrCharacterInvalid   display contained /b\?'\zs[\n\r\t']\ze'/
syn match     rbrCharacterInvalidUnicode display contained /b'\zs[^[:cntrl:][:graph:]]\ze'/
syn match     rbrCharacter           /b'\([^\\']\|\\\([nrt0\\'"]\|x\x\{2}\)\)'/ contains=rbrEscape,rbrEscapeError,rbrCharacterInvalid,rbrCharacterInvalidUnicode
syn match     rbrCharacter           /'\([^\\']\|\\\([nrt0\\'"]\|x\x\{2}\|u{\%(\x_*\)\{1,6}}\)\)'/ contains=rbrEscape,rbrEscapeUnicode,rbrEscapeError,rbrCharacterInvalid

syn keyword   rbrKeyword      struct enum trait impl let if else fn while for loop return raise error break continue
syn keyword   rbrBoolean      true false
syn keyword   rbrType         bool str i8 i16 i32 i64 i128 u8 u16 u32 u64 u128 f32 f64
syn match     rbrType         display "\<\u\w*"

syn match     rbrPathSep      display "::"
syn match     rbrDelimiter    display "(\|)"
syn match     rbrModName      display "\%(\l\w*\):"he=e-1,me=e-1
syn match     rbrDefinition   display "\%(\w\+\)("he=e-1,me=e-1

syn match     rbrDecNumber   display "\<[0-9][0-9_]*"

syn region rbrComment         start="//" end="$"   contains=rbrTodo,@Sperbr
syn region rbrComment         start="/\*" end="\*/" contains=rbrTodo,@Spell

syn keyword rbrTodo contained TODO FIXME XXX NB NOTE SAFETY

hi def link rbrDecNumber       rbrNumber

hi def link rbrKeyword         Keyword
hi def link rbrBoolean         Boolean
hi def link rbrType            Type
hi def link rbrString          String
hi def link rbrStringDelimiter String
hi def link rbrChar            Character
hi def link rbrCharDelimiter   Character
hi def link rbrEscape          Special
hi def link rbrEscapeUnicode   rbrEscape
hi def link rbrEscapeError             Error
hi def link rbrCharacter               Character
hi def link rbrCharacterInvalid        Error
hi def link rbrCharacterInvalidUnicode rbrCharacterInvalid
hi def link rbrInterpolationDelimiter  Special
hi def link rbrDefinition      Function
hi def link rbrPathSep         Delimiter
hi def link rbrDelimiter       Delimiter
hi def link rbrModName         Identifier
hi def link rbrNumber          Number
hi def link rbrOperator        Operator
hi def link rbrComment         Comment
hi def link rbrTodo            Todo

syn sync minlines=200
syn sync maxlines=500

let b:current_syntax = "rebar"
