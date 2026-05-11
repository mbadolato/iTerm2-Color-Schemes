#!/bin/sh
# Karma Dark Dimmed

# source for these helper functions:
# https://github.com/chriskempson/base16-shell/blob/master/templates/default.mustache
if [ -n "$TMUX" ]; then
  # Tell tmux to pass the escape sequences through
  # (Source: http://permalink.gmane.org/gmane.comp.terminal-emulators.tmux.user/1324)
  put_template() { printf '\033Ptmux;\033\033]4;%d;rgb:%s\033\033\\\033\\' $@; }
  put_template_var() { printf '\033Ptmux;\033\033]%d;rgb:%s\033\033\\\033\\' $@; }
  put_template_custom() { printf '\033Ptmux;\033\033]%s%s\033\033\\\033\\' $@; }
elif [ "${TERM%%[-.]*}" = "screen" ]; then
  # GNU screen (screen, screen-256color, screen-256color-bce)
  put_template() { printf '\033P\033]4;%d;rgb:%s\007\033\\' $@; }
  put_template_var() { printf '\033P\033]%d;rgb:%s\007\033\\' $@; }
  put_template_custom() { printf '\033P\033]%s%s\007\033\\' $@; }
elif [ "${TERM%%-*}" = "linux" ]; then
  put_template() { [ $1 -lt 16 ] && printf "\e]P%x%s" $1 $(echo $2 | sed 's/\///g'); }
  put_template_var() { true; }
  put_template_custom() { true; }
else
  put_template() { printf '\033]4;%d;rgb:%s\033\\' $@; }
  put_template_var() { printf '\033]%d;rgb:%s\033\\' $@; }
  put_template_custom() { printf '\033]%s%s\033\\' $@; }
fi

# 16 color space
put_template 0  "14/18/1f"
put_template 1  "e8/76/91"
put_template 2  "82/c8/91"
put_template 3  "eb/d8/70"
put_template 4  "6c/c4/d2"
put_template 5  "a8/92/d4"
put_template 6  "6c/c4/d2"
put_template 7  "a8/a4/ae"
put_template 8  "5c/5a/5f"
put_template 9  "e8/86/9c"
put_template 10 "98/ce/a4"
put_template 11 "eb/d8/70"
put_template 12 "80/c8/d2"
put_template 13 "b6/a4/d6"
put_template 14 "80/c8/d2"
put_template 15 "e2/de/f0"

color_foreground="e2/de/f0"
color_background="14/18/1f"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "e2def0"
  put_template_custom Ph "14181f"
  put_template_custom Pi "f0eafa"
  put_template_custom Pj "2f2d3d"
  put_template_custom Pk "e2def0"
  put_template_custom Pl "ebd870"
  put_template_custom Pm "14181f"
else
  put_template_var 10 $color_foreground
  put_template_var 11 $color_background
  if [ "${TERM%%-*}" = "rxvt" ]; then
    put_template_var 708 $color_background # internal border (rxvt)
  fi
  put_template_custom 12 ";7" # cursor (reverse video)
fi

# clean up
unset -f put_template
unset -f put_template_var
unset -f put_template_custom

unset color_foreground
unset color_background
