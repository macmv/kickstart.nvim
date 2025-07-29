" Vim syntax file for BlueDB schema

" quit when a syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

syn case ignore

syn match bdbIdentifier  "[a-zA-Z][a-zA-Z0-9_]*" display
syn match bdbFuncCall    "[a-zA-Z][a-zA-Z0-9_]*("he=e-1,me=e-1 display

syn match bdbDecimal     "\<[0-9]\d*\>"           display
syn match bdbHexadecimal "\<0[xX][0-9a-fA-F]\+\>" display
syn match bdbBinary      "\<0[bB][0-1]\+\>"       display

syn match bdbCharacterEscape "\\."    contained
syn match bdbCharacter       "'\\\=." contains=bdbCharacterEscape

syn match bdbStringEscape    "\\\_."                   contained
syn match bdbStringEscape    "\\\%(\o\{3}\|00[89]\)"   contained display
syn match bdbStringEscape    "\\x\x\+"                 contained display

syn match bdbOperator        display "\%(+\|-\|/\|*\|=\|\^\|&\||\|!\|>\|<\|%\)=\?"

syn region bdbString         start="\"" end="\"" skip="\\\\\|\\\"" contains=bdbStringEscape
syn keyword bdbTodo          contained TODO FIXME XXX NOTE
syn region bdbComment        start="//" end="$" keepend contains=bdbTodo,@Spell

syn match bdbDelimiter       "\%(:\|;\|\.\|,\|(\|)\|\[\|\]\|{\|}\)"       display
syn keyword bdbKeyword       category key store history index route
syn keyword bdbType          i8 i16 i32 i64 u8 u16 u32 u64 f32 f64 bool string time duration array option map

syn case match

syn match bdbConstant    "[A-Z_][A-Z0-9_]*"

" Define the default highlighting.
" Only when an item doesn't have highlighting yet

" The default methods for highlighting.  Can be overridden later
hi def link bdbNamedLabel    bdbLabel
hi def link bdbUnnamedLabel  bdbLabel
hi def link bdbLabel         Label
hi def link bdbComment       Comment
hi def link bdbTodo          Todo
hi def link bdbHexadecimal    Number
hi def link bdbDecimal        Number
hi def link bdbOctal          Number
hi def link bdbBinary         Number

hi def link bdbConstant         Constant
hi def link bdbString           String
hi def link bdbStringEscape     Special
hi def link bdbCharacter        Character
hi def link bdbCharacterEscape  Special

hi def link bdbIdentifier   Identifier
hi def link bdbFuncCall     Function
hi def link bdbKeyword      Keyword
hi def link bdbType         Type
hi def link bdbBranch       Label
hi def link bdbRegister     Keyword
hi def link bdbDelimiter    Delimiter
hi def link bdbOperator     Operator

let b:current_syntax = "bluedb"

let &cpo = s:cpo_save
unlet s:cpo_save

" vim: nowrap sw=2 sts=2 ts=8 noet
