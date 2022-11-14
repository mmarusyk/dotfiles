# My dotfiles repository

## Installation

**Warning:** If you want use this dotfiles, you should first review the code and remove things that you don't want have.

```
git clone https://github.com/mmarusyk/dotfiles.git && cd dotfiles && ./install.sh
```

If you want to run a specific script use the next command:

```
./path_to_install_script/install.sh
```

## Documentation

### Vim CTRL keys on Visual Studio Code


| Key combination | Visual Studio Code behavior      | VSCodeVim behavior                                            | Default | Keybinding change.                                                                         |
| --------------- | -------------------------------- | ------------------------------------------------------------- | ------- | ------------------------------------------------------------------------------------------ |
| CTRL+q          | Quick navigation                 | normal: visual block mode                                     | vim     | Prefer VSCode. Though I never use quick navigation, I prefer CTRL+v for visual block mode. |
| CTRL+w          | View: Close editor               | insert: delete previous word                                  | vim     |                                                                                            |
|                 |                                  | normal: many window manipulations                             | vim     |                                                                                            |
| CTRL+e          | File: Goto file … (CTRL+p)      | insert: insert same character as next line                    | vim     |                                                                                            |
|                 |                                  | normal: move file down one line                               | vim     |                                                                                            |
| CTRL+r          | File: Open recent…              | insertion: insert from register.                              | vim     |                                                                                            |
|                 |                                  | normal: redo                                                  | vim     |                                                                                            |
| CTRL+t          | Goto symbol                      | insert: indent line                                           | vim     | Prefer VSCode. I use » and « for indent.                                                 |
| CTRL+y          | redo                             | insert: insert character from above the cursor                | vim     |                                                                                            |
|                 |                                  | normal: move screen up one line                               | vim     |                                                                                            |
| CTRL+u          | cursor undo                      | insert: delete line up to cursor                              | vim     |                                                                                            |
|                 |                                  | normal: move back 1/2 screen                                  | vim     |                                                                                            |
| CTRL+i          | trigger suggest                  | normal: go to newer position in jump list                     | vim     |                                                                                            |
| CTRL+o          | File: Open file…                | insert: go back to normal mode for 1 keystroke                | vim     |                                                                                            |
|                 |                                  | normal: go to older position in jump list                     | vim     |                                                                                            |
| CTRL+p          | Go to file…                     | insert: insert previous matching identifier                   | VSCode  | Note: Use CTRL+space for same behavior.                                                    |
| CTRL+a          | Select All                       | insert: insert previously inserted text                       | vim     |                                                                                            |
|                 |                                  | normal: increment number under cursor                         | vim     |                                                                                            |
| CTRL+s          | File: Save                       | nothing (This used to be the disasterous XOFF command in vi.) | VSCode  |                                                                                            |
| CTRL+d          | Add selection to next find match | normal: Move forward 1/2 screen                               | vim     |                                                                                            |
| CTRL+f          | Find                             | insert: Find                                                  | VSCode  |                                                                                            |
|                 |                                  | normal: move forward 1 screen                                 | vim     |                                                                                            |
| CTRL+g          | Go to Line/Column                | normal: Show file and line number info                        | vim     | Either way, so leave default.                                                              |
| CTRL+h          | Replace                          | insert: Backspace                                             | vim     |                                                                                            |
| CTRL+j          | Toggle Panel                     | normal: move to next line                                     | vim     |                                                                                            |
| CTRL+k          | Start of many VSCode commands    | insert: insert digraph                                        | vim     | Prefer VSCode. Enabled dozens more keyboard shortcuts.                                     |
| CTRL+l          | Expand line selection            | Some kind of navigation? Didn’t seem to work                 | vim     |                                                                                            |
| CTRL+z          | Undo                             |                                                               | VSCode  |                                                                                            |
| CTRL+x          | Cut                              | insert: Esc                                                   | vim     |                                                                                            |
|                 |                                  | normal: decrement number under cursor                         | vim     |                                                                                            |
| CTRL+c          | Copy                             | insert: Esc                                                   | vim     |                                                                                            |
| CTRL+v          | Paste                            | normal: Visual block                                          | vim     |                                                                                            |
| CTRL+b          | View: Toggle side bar visibility | insert: nothing                                               | VSCode  |                                                                                            |
|                 |                                  | normal: go up one page                                        | vim     |                                                                                            |
| CTRL+n          | Create: New File…               | insert: insert next matching identifier                       | vim     |                                                                                            |
|                 |                                  | normal: go down one line                                      | vim     |                                                                                            |
| CTRL+m          | Toggle Tab Key Moves Focus       | insert: newline                                               | vim     |                                                                                            |
|                 |                                  | normal: go to start of next line                              | vim     |                                                                                            |
