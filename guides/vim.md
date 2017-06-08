# Vim guide

Useful vim tricks

## List open files
:ls

## Buffers
:bp previous buffer
:bn next buffer
:bn (n a number) move to n'th buffer
:b <filename-part> with tab-key providing auto-completion (awesome !!)


## Save session
:mksession! ~/today.ses

## Using windows

Ctrl-W s and Ctrl-W v to split the current window horizontally and vertically. You can also use :split and :vertical split (:sp and :vs)

Ctrl-W w " to switch between open windows, and Ctrl-W h (or j or k or l) to navigate through open windows.

Ctrl-W c " to close the current window, and Ctrl-W o to close all windows except the current one.

Starting vim with a -o or -O flag opens each file in its own split.

## Cut/Copy and paste

* Position the cursor where you want to begin cutting.
* Press v to select characters (or uppercase V to select whole lines, or Ctrl-v to select rectangular blocks).
* Move the cursor to the end of what you want to cut.
* Press d to cut (or y to copy).
* Move to where you would like to paste.
* Press P to paste before the cursor, or p to paste after.
* Copy and paste is performed with the same steps except for step 4 where you would press y instead of d:

* d stands for delete in Vim, which in other editors is usually called cut
* y stands for yank in Vim, which in other editors is usually called copy


