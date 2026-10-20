# Assert "no mouse reporting" at every prompt.
#
# Full-screen programs ask the terminal to report mouse events by setting a
# private mode -- 1000 (clicks), 1002 (clicks + drags), 1003 (*every* pointer
# motion), plus 1006/1015/1005 to pick the encoding of those reports. They're
# supposed to unset it on the way out, but anything that dies on a signal, a
# crash, or a closed pipe never gets there, and the terminal has no reason to
# second-guess a mode that was legitimately set.
#
# What's left behind is a terminal that keeps writing things like
# `^[[<35;80;24M` to the shell every time the pointer moves. ZLE has no binding
# for `^[[<`, so it beeps, then self-inserts the remainder as literal digits and
# semicolons -- the "codes and bells" on mouse-over. Only 1003 produces this on
# bare movement; 1000/1002 need a button held, which is why it looks like the
# terminal is possessed rather than merely twitchy.
#
# tmux masks the whole class of bug because it owns the outer terminal's mouse
# state: reports are consumed by tmux and never reach the pane's shell, and
# tmux re-asserts its own modes constantly. So the damage is only visible in
# bare Ghostty windows -- which is exactly when it shows up.
#
# There's no terminal-side switch for this (Ghostty has no "ignore mouse
# reporting" option, and shouldn't -- it can't tell a leak from a request), so
# the shell is the right place to fix it: make each prompt state the mode it
# wants. A stuck window then heals the instant you get a prompt back, whichever
# program leaked.
_mouse_reporting_off() {
  [[ -t 1 ]] || return
  # 1000/1002/1003 tracking, 1005/1006/1015 report encodings, and 1004 focus
  # in/out -- the last isn't mouse, but it's the same species of leftover and
  # shows up as stray `^[[I` / `^[[O` when you click between windows.
  printf '\e[?1000l\e[?1002l\e[?1003l\e[?1004l\e[?1005l\e[?1006l\e[?1015l'
}

# add-zsh-hook is autoloaded here rather than assumed: this file sorts ahead of
# the plugins that would otherwise have pulled it in.
autoload -U add-zsh-hook
add-zsh-hook precmd _mouse_reporting_off
