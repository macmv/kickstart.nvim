" Vim syntax file
" Language:     fsl

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" Syntax definitions {{{1
" Basic keywords {{{2
syn keyword   fslConditional match if else
" syn keyword   fslTypedef type nextgroup=fslIdentifier skipwhite skipempty
" syn keyword   fslStructure struct enum nextgroup=fslIdentifier skipwhite skipempty
" syn keyword   fslUnion union nextgroup=fslIdentifier skipwhite skipempty contained
" syn match fslUnionContextual /\<union\_s\+\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct:][:space:]]\|_\)*/ transparent contains=fslUnion
syn keyword   fslOperator    as

syn keyword   fslKeyword     collection function role access provider index terms values unique check compute privileges let migrations add backfill move split move_conflicts move_wildcard add_wildcard
syn keyword   fslType        Collection fsl Function Math String Number Boolean Time

syn match     fslIdentifier  contains=fslIdentifierPrime "\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct:][:space:]]\|_\)*" display contained
syn match     fslFuncName    "\%(r#\)\=\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct:][:space:]]\|_\)*" display contained
syn match     fslProperty    "\w\(\w\)*:"he=e-1,me=e-1
syn match     fslProperty    ".\w\(\w\)*"hs=s+1,ms=s+1

syn match     fslRawIdent "`\w*`"

syn keyword   fslFunc asc desc dbg log
syn keyword   fslAbort abort

syn keyword   fslBoolean     true false

syn match     fslFuncCall    "\w\(\w\)*("he=e-1,me=e-1
syn match     fslOperator     display "\%(+\|-\|/\|*\|=\|\^\|&\||\|!\|>\|<\|%\)=\?"

syn match     fslSigil        display /&\s\+[&~@*][^)= \t\r\n]/he=e-1,me=e-1
syn match     fslSigil        display /[&~@*][^)= \t\r\n]/he=e-1,me=e-1
syn match     fslOperator     display "&&\|||"

syn match     fslEscapeError   display contained /\\./
syn match     fslEscape        display contained /\\\([nrt0\\'"]\|x\x\{2}\)/
syn match     fslEscapeUnicode display contained /\\u{\%(\x_*\)\{1,6}}/
syn match     fslStringContinuation display contained /\\\n\s*/
syn region    fslString      matchgroup=fslStringDelimiter start=+b"+ skip=+\\\\\|\\"+ end=+"+ contains=fslEscape,fslEscapeError,fslStringContinuation
syn region    fslString      matchgroup=fslStringDelimiter start=+"+ skip=+\\\\\|\\"+ end=+"+ contains=fslEscape,fslEscapeUnicode,fslEscapeError,fslStringContinuation,@Spell
syn region    fslString      matchgroup=fslStringDelimiter start='b\?r\z(#*\)"' end='"\z1' contains=@Spell

" Number literals
syn match     fslDecNumber   display "\<[0-9][0-9_]*\%([iu]\%(size\|8\|16\|32\|64\|128\)\)\="
syn match     fslHexNumber   display "\<0x[a-fA-F0-9_]\+\%([iu]\%(size\|8\|16\|32\|64\|128\)\)\="
syn match     fslOctNumber   display "\<0o[0-7_]\+\%([iu]\%(size\|8\|16\|32\|64\|128\)\)\="
syn match     fslBinNumber   display "\<0b[01_]\+\%([iu]\%(size\|8\|16\|32\|64\|128\)\)\="

" Special case for numbers of the form "1." which are float literals, unless followed by
" an identifier, which makes them integer literals with a method call or field access,
" or by another ".", which makes them integer literals followed by the ".." token.
" (This must go first so the others take precedence.)
syn match     fslFloat       display "\<[0-9][0-9_]*\.\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\|\.\)\@!"
" To mark a number as a normal float, it must have at least one of the three things integral values don't have:
" a decimal point and more numbers; an exponent; and a type suffix.
syn match     fslFloat       display "\<[0-9][0-9_]*\%(\.[0-9][0-9_]*\)\%([eE][+-]\=[0-9_]\+\)\=\(f32\|f64\)\="
syn match     fslFloat       display "\<[0-9][0-9_]*\%(\.[0-9][0-9_]*\)\=\%([eE][+-]\=[0-9_]\+\)\(f32\|f64\)\="
syn match     fslFloat       display "\<[0-9][0-9_]*\%(\.[0-9][0-9_]*\)\=\%([eE][+-]\=[0-9_]\+\)\=\(f32\|f64\)"

syn region fslCommentLine                             start="//"                      end="$"   contains=fslTodo,@Spell
syn region fslCommentBlock matchgroup=fslCommentBlock start="/\*\%(!\|\*[*/]\@!\)\@!" end="\*/" contains=fslTodo,fslCommentBlockNest,@Spell

syn keyword fslTodo contained TODO FIXME XXX NB NOTE SAFETY

" Folding rules {{{2
" Trivial folding rules to begin with.
" FIXME: switch to LSP for folding
syn region fslFoldBraces start="{" end="}" transparent fold

" Default highlighting {{{1
hi def link fslDecNumber       fslNumber
hi def link fslHexNumber       fslNumber
hi def link fslOctNumber       fslNumber
hi def link fslBinNumber       fslNumber
hi def link fslIdentifierPrime fslIdentifier

hi def link fslSigil         StorageClass
hi def link fslEscape        Special
hi def link fslEscapeUnicode fslEscape
hi def link fslEscapeError   Error
hi def link fslStringContinuation Special
hi def link fslString        String
hi def link fslStringDelimiter String
hi def link fslNumber        Number
hi def link fslBoolean       Boolean
hi def link fslFloat         Float
hi def link fslOperator      Operator
hi def link fslKeyword       Operator
hi def link fslType          Type
hi def link fslStructure     Keyword " More precise is Structure
hi def link fslUnion         fslStructure
hi def link fslConditional   Conditional
hi def link fslIdentifier    Identifier
hi def link fslRawIdent      fslIdentifier
hi def link fslFunc          Macro
hi def link fslFuncName      Function
hi def link fslProperty      Identifier
hi def link fslFuncCall      Function
hi def link fslCommentLine   Comment
hi def link fslCommentBlock  fslCommentLine
hi def link fslAbort         PreCondit
hi def link fslType          Type
hi def link fslTodo          Todo

syn sync minlines=200
syn sync maxlines=500

let b:current_syntax = "fsl"
