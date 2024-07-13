" Vim syntax file
" Language:     FQL

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" Syntax definitions {{{1
" Basic keywords {{{2
syn keyword   fqlConditional match if else
" syn keyword   fqlTypedef type nextgroup=fqlIdentifier skipwhite skipempty
" syn keyword   fqlStructure struct enum nextgroup=fqlIdentifier skipwhite skipempty
" syn keyword   fqlUnion union nextgroup=fqlIdentifier skipwhite skipempty contained
" syn match fqlUnionContextual /\<union\_s\+\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct:][:space:]]\|_\)*/ transparent contains=fqlUnion
syn keyword   fqlOperator    as

syn keyword   fqlKeyword     let

syn match     fqlIdentifier  contains=fqlIdentifierPrime "\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct:][:space:]]\|_\)*" display contained
syn match     fqlFuncName    "\%(r#\)\=\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct:][:space:]]\|_\)*" display contained

syn match     fqlRawIdent "`\w*`"

syn keyword   fqlFunc asc desc dbg log
syn keyword   fqlAbort abort
syn keyword   fqlType Collection FQL Function Math

syn keyword   fqlBoolean     true false

syn match     fqlFuncCall    "\w\(\w\)*("he=e-1,me=e-1
syn match     fqlOperator     display "\%(+\|-\|/\|*\|=\|\^\|&\||\|!\|>\|<\|%\)=\?"
syn match     fqlProperty    "\w\(\w\)*:"he=e-1,me=e-1

syn match     fqlSigil        display /&\s\+[&~@*][^)= \t\r\n]/he=e-1,me=e-1
syn match     fqlSigil        display /[&~@*][^)= \t\r\n]/he=e-1,me=e-1
syn match     fqlOperator     display "&&\|||"

syn match     fqlEscapeError   display contained /\\./
syn match     fqlEscape        display contained /\\\([nrt0\\'"]\|x\x\{2}\)/
syn match     fqlEscapeUnicode display contained /\\u{\%(\x_*\)\{1,6}}/
syn match     fqlStringContinuation display contained /\\\n\s*/
syn region    fqlString      matchgroup=fqlStringDelimiter start=+b"+ skip=+\\\\\|\\"+ end=+"+ contains=fqlEscape,fqlEscapeError,fqlStringContinuation
syn region    fqlString      matchgroup=fqlStringDelimiter start=+"+ skip=+\\\\\|\\"+ end=+"+ contains=fqlEscape,fqlEscapeUnicode,fqlEscapeError,fqlStringContinuation,@Spell
syn region    fqlString      matchgroup=fqlStringDelimiter start='b\?r\z(#*\)"' end='"\z1' contains=@Spell

" Number literals
syn match     fqlDecNumber   display "\<[0-9][0-9_]*\%([iu]\%(size\|8\|16\|32\|64\|128\)\)\="
syn match     fqlHexNumber   display "\<0x[a-fA-F0-9_]\+\%([iu]\%(size\|8\|16\|32\|64\|128\)\)\="
syn match     fqlOctNumber   display "\<0o[0-7_]\+\%([iu]\%(size\|8\|16\|32\|64\|128\)\)\="
syn match     fqlBinNumber   display "\<0b[01_]\+\%([iu]\%(size\|8\|16\|32\|64\|128\)\)\="

" Special case for numbers of the form "1." which are float literals, unless followed by
" an identifier, which makes them integer literals with a method call or field access,
" or by another ".", which makes them integer literals followed by the ".." token.
" (This must go first so the others take precedence.)
syn match     fqlFloat       display "\<[0-9][0-9_]*\.\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\|\.\)\@!"
" To mark a number as a normal float, it must have at least one of the three things integral values don't have:
" a decimal point and more numbers; an exponent; and a type suffix.
syn match     fqlFloat       display "\<[0-9][0-9_]*\%(\.[0-9][0-9_]*\)\%([eE][+-]\=[0-9_]\+\)\=\(f32\|f64\)\="
syn match     fqlFloat       display "\<[0-9][0-9_]*\%(\.[0-9][0-9_]*\)\=\%([eE][+-]\=[0-9_]\+\)\(f32\|f64\)\="
syn match     fqlFloat       display "\<[0-9][0-9_]*\%(\.[0-9][0-9_]*\)\=\%([eE][+-]\=[0-9_]\+\)\=\(f32\|f64\)"

syn region fqlCommentLine                             start="//"                      end="$"   contains=fqlTodo,@Spell
syn region fqlCommentBlock matchgroup=fqlCommentBlock start="/\*\%(!\|\*[*/]\@!\)\@!" end="\*/" contains=fqlTodo,fqlCommentBlockNest,@Spell

syn keyword fqlTodo contained TODO FIXME XXX NB NOTE SAFETY

" Folding rules {{{2
" Trivial folding rules to begin with.
" FIXME: switch to LSP for folding
syn region fqlFoldBraces start="{" end="}" transparent fold

" Default highlighting {{{1
hi def link fqlDecNumber       fqlNumber
hi def link fqlHexNumber       fqlNumber
hi def link fqlOctNumber       fqlNumber
hi def link fqlBinNumber       fqlNumber
hi def link fqlIdentifierPrime fqlIdentifier

hi def link fqlSigil         StorageClass
hi def link fqlEscape        Special
hi def link fqlEscapeUnicode fqlEscape
hi def link fqlEscapeError   Error
hi def link fqlStringContinuation Special
hi def link fqlString        String
hi def link fqlStringDelimiter String
hi def link fqlNumber        Number
hi def link fqlBoolean       Boolean
hi def link fqlFloat         Float
hi def link fqlOperator      Operator
hi def link fqlKeyword       Keyword
hi def link fqlStructure     Keyword " More precise is Structure
hi def link fqlUnion         fqlStructure
hi def link fqlConditional   Conditional
hi def link fqlIdentifier    Identifier
hi def link fqlRawIdent      fqlIdentifier
hi def link fqlFunc          Macro
hi def link fqlFuncName      Function
hi def link fqlFuncCall      Function
hi def link fqlProperty      Identifier
hi def link fqlCommentLine   Comment
hi def link fqlCommentBlock  fqlCommentLine
hi def link fqlAbort         PreCondit
hi def link fqlType          Type
hi def link fqlTodo          Todo

syn sync minlines=200
syn sync maxlines=500

let b:current_syntax = "fql"
