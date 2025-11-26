#!/bin/sh
# One Dark Two

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
put_template 0  "1d/1f/23"
put_template 1  "e2/78/81"
put_template 2  "98/c3/79"
put_template 3  "ea/c7/86"
put_template 4  "71/b9/f4"
put_template 5  "c8/8b/da"
put_template 6  "62/ba/c6"
put_template 7  "c9/cc/d3"
put_template 8  "4a/50/5a"
put_template 9  "e6/89/91"
put_template 10 "a8/cc/8e"
put_template 11 "ed/cf/97"
put_template 12 "8d/c7/f6"
put_template 13 "d3/a2/e2"
put_template 14 "78/c4/ce"
put_template 15 "e6/e6/e6"

color_foreground="e6/e6/e6"
color_background="21/25/2b"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "e6e6e6"
  put_template_custom Ph "21252b"
  put_template_custom Pi "e6e6e6"
  put_template_custom Pj "393e47"
  put_template_custom Pk "e6e6e6"
  put_template_custom Pl "e6e6e6"
  put_template_custom Pm "1d1f23"
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
