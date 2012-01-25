" Maintainer:	Lars H. Nielsen (dengmao@gmail.com)
" Last Change:	January 22 2007

set background=dark

hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "wombat"


" Vim >= 7.0 specific colors
if version >= 700
  hi CursorLine guibg=#2d302d 
  hi CursorColumn guibg=#2d2d2d
  hi MatchParen guifg=#f6f3e8 guibg=#857b6f gui=bold
  hi Pmenu 		guifg=#f6f3e8 guibg=#444444
  hi PmenuSel 	guifg=#000000 guibg=#cae682
  hi Search     guifg=#444444 guibg=#af87d7
  hi WarningMsg guifg=#ff0000
endif

" General colors
hi Cursor 		guifg=NONE    guibg=#656565 gui=none
hi Normal 		guifg=#f6f3e8 guibg=#242424 gui=none
hi NonText 		guifg=#808080 guibg=#303030 gui=none
hi LineNr 		guifg=#857b6f guibg=#111111 gui=none
hi StatusLine 	guifg=#f6f3e8 guibg=#704000 gui=italic
hi StatusLineNC guifg=#857b6f guibg=#444444 gui=none
hi VertSplit 	guifg=#444444 guibg=#444444 gui=none
hi Folded 		guibg=#303030 guifg=#656565 gui=none
hi Title		guifg=#f6f3e8 guibg=#555555	gui=bold
hi Visual		guifg=#f6f3e8 guibg=#557799 gui=none
hi SpecialKey	guifg=#808080 guibg=#343434 gui=none

" Syntax highlighting
hi Comment 		guifg=#99968b gui=italic
hi Todo 		guifg=#8f8f8f gui=italic
hi Constant 	guifg=#e5786d gui=none
hi String 		guifg=#e5786d gui=italic
hi Identifier 	guifg=#cae682 gui=none
hi Function 	guifg=#cae682 gui=none
hi Type 		guifg=#cae682 gui=none
hi Statement 	guifg=#aaa6f2 gui=none
hi Keyword		guifg=#aaa6f2 gui=none
hi PreProc 		guifg=#e5786d gui=none
hi Number		guifg=#8ac6f2 gui=none
hi Special		guifg=#e7f6da gui=none


hi! link VisualNOS	Visual
hi! link FoldColumn	Folded

