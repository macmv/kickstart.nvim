" Vim syntax file for 6502 assembly

" quit when a syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

syn case ignore

syn match asmIdentifier   "[a-z_][a-z0-9_]*"
syn match asmNamedLabel   "^ *[a-z0-9_]*:"he=e-1
syn match asmUnnamedLabel "^ *:"
syn match asmLabelUse     ":[a-z0-9_]*"hs=s+1

syn match asmDecimal     "\<[1-9]\d*\>"           display
syn match asmHexadecimal "\<0[xX][0-9a-fA-F]\+\>" display
syn match asmBinary      "\<0[bB][0-1]\+\>"       display

syn match asmCharacterEscape "\\."    contained
syn match asmCharacter       "'\\\=." contains=asmCharacterEscape

syn match asmStringEscape    "\\\_."                   contained
syn match asmStringEscape    "\\\%(\o\{3}\|00[89]\)"   contained display
syn match asmStringEscape    "\\x\x\+"                 contained display

syn region asmString         start="\"" end="\"" skip="\\\\\|\\\"" contains=asmStringEscape
syn keyword asmTodo          contained TODO FIXME XXX NOTE
syn region asmComment        start="#" end="$" keepend contains=asmTodo,@Spell

syn match asmDelimiter       "\[\|]"       display
syn match asmOperator        "+\|-"        display
syn keyword asmRegister      a x y sp
syn keyword asmKeyword       brk rti rts jsr jmp
syn keyword asmBranch        bcc bcs beq bmi bne bpl bvc bvs

syn case match

syn match asmConstant    "[A-Z_][A-Z0-9_]*"

" Define the default highlighting.
" Only when an item doesn't have highlighting yet

" The default methods for highlighting.  Can be overridden later
hi def link asmNamedLabel    asmLabel
hi def link asmUnnamedLabel  asmLabel
hi def link asmLabel         Label
hi def link asmComment       Comment
hi def link asmTodo          Todo

if exists('g:asm_legacy_syntax_groups')
  hi def link hexNumber         Number
  hi def link decNumber         Number
  hi def link octNumber         Number
  hi def link binNumber         Number
  hi def link asmHexadecimal    hexNumber
  hi def link asmDecimal        decNumber
  hi def link asmOctal          octNumber
  hi def link asmBinary         binNumber
else
  hi def link asmHexadecimal    Number
  hi def link asmDecimal        Number
  hi def link asmOctal          Number
  hi def link asmBinary         Number
endif

hi def link asmConstant         Constant
hi def link asmString           String
hi def link asmStringEscape     Special
hi def link asmCharacter        Character
hi def link asmCharacterEscape  Special

hi def link asmIdentifier       Identifier
hi def link asmKeyword          Keyword
hi def link asmBranch           Label
hi def link asmRegister         Keyword
hi def link asmDelimiter        Delimiter
hi def link asmOperator         Operator

let b:current_syntax = "asm6502"

let &cpo = s:cpo_save
unlet s:cpo_save

" vim: nowrap sw=2 sts=2 ts=8 noet
