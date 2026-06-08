#!/bin/sh
# Mesila One

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
put_template 0  "10/14/18"
put_template 1  "93/86/7f"
put_template 2  "5c/c8/ff"
put_template 3  "eb/b3/a9"
put_template 4  "de/c1/ff"
put_template 5  "7d/70/ba"
put_template 6  "5c/c8/ff"
put_template 7  "e9/fa/e3"
put_template 8  "7d/70/ba"
put_template 9  "93/86/7f"
put_template 10 "5c/c8/ff"
put_template 11 "eb/b3/a9"
put_template 12 "de/c1/ff"
put_template 13 "7d/70/ba"
put_template 14 "5c/c8/ff"
put_template 15 "e9/fa/e3"

color_foreground="e9/fa/e3"
color_background="1b/1f/23"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "e9fae3"
  put_template_custom Ph "1b1f23"
  put_template_custom Pi "e9fae3"
  put_template_custom Pj "334155"
  put_template_custom Pk "676b6f"
  put_template_custom Pl "5cc8ff"
  put_template_custom Pm "1b1f23"
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
