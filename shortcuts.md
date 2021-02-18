# Shortcuts and Commands Cheat Sheets

## Git
git co - git checkout
git br - git branch
git ci - git commit
git st - git status

## Vim

### Movement

`h`, `j`, `k`, `l` - basic movement keys.

`b`, `w`, `B`, `W` - Move back by token/forward by token/back by word/forward by word.

`0`, `^`, `$` - Jump to first column/first non-whitespace character/end of line.

`ctrl+u`, `ctrl+d` - Page Up and Page Down.

`<line-number>G` - Specific line number.

`H`, `M`, `L` - Move to the top/middle/bottom of the screen.

`#`, `*` - Find the previous/next occurrence of the token under the cursor.

`n`, `N` - Repeat the last find command forward/backward.

`"` - Jump back to where you just were.

`ctrl+o`, `ctrl+i` - Move backward/forward through the jump history.

### Editing

`i`, `a`, `I`, `A` - Enter insert mode (insert at cursor/append after cursor/insert at beginning of line/append to end of line).

`o`, `O` - Open new line (below the current line/above the current line).

`cw`, `cW` - Correct the token(s)/word(s) following the cursor. Basically combines delete and insert into one step.

`cc` - Correct line(s) by clearing and then entering insert mode. Starts inserting at the current indent level.

`dd` - Delete line(s).

`ct`, `cf`, `ci`, `ca`;
`dt`, `df`, `di`, `da` - Correct/delete up to or including specific characters. Since there are many variations, I break it down in the section below about correcting text.

`s` - Delete character(s) at the cursor and then enter insert mode.

`yy` - Copy line(s).  The “y” is for “yank.”

`yw`, `yW` - Copy token(s)/word(s).

`p`, `P` - Paste the last thing that was deleted or copied before/after cursor.

`y`, `ctrl+r` - Undo and redo.

`.` - Repeat the previous edit command.

### Searching

`/` - Search something.

## Tmux

### Panes
`Ctrl + b ;` - Toggle last active pane.

`Ctrl + b %` - Split pane vertically

`Ctrl + b "` - Split pane horizontally

`Ctrl + b {` - Move the current pane left

`Ctrl + b }` - Move the current pane right

`Ctrl + b Up`; `Ctrl + b Down`; `Ctrl + b Right`; `Ctrl + b Left` - Switch to pane to the direction

`Ctrl + b Spacebar` - Toggle between pane layouts

`Ctrl + b o` - Switch to next pane

`Ctrl + b q` - Show pane numbers

`Ctrl + b q 0` ... `9` - Switch/select pane by number

`Ctrl + b z` - Toggle pane zoom

`Ctrl + b !` - Convert pane into a window

`Ctrl + b + Up`
`Ctrl + b Ctrl + Up`
`Ctrl + b + Down`
`Ctrl + b Ctrl + Down` - Resize current pane height(holding second key is optional)

`Ctrl + b + Right`
`Ctrl + b Ctrl + Right`
`Ctrl + b + Left`
`Ctrl + b Ctrl + Left` - Resize current pane width(holding second key is optional)

`Ctrl + b x` - Close current pane
