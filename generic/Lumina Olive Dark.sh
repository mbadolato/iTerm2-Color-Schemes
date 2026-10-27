#!/bin/sh
# Lumina Olive Dark

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
put_template 0  "1f/20/0f"
put_template 1  "d3/72/6a"
put_template 2  "b5/d5/c6"
put_template 3  "eb/c2/7c"
put_template 4  "a2/c4/f0"
put_template 5  "d5/a2/d0"
put_template 6  "8b/cf/d7"
put_template 7  "c1/bf/ae"
put_template 8  "8c/8c/76"
put_template 9  "e0/93/8c"
put_template 10 "b5/f7/da"
put_template 11 "ff/de/a7"
put_template 12 "c4/dd/ff"
put_template 13 "f0/bb/eb"
put_template 14 "a3/e9/f2"
put_template 15 "e1/df/ce"

color_foreground="e1/df/ce"
color_background="1a/1b/0c"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "e1dfce"
  put_template_custom Ph "1a1b0c"
  put_template_custom Pi "e1dfce"
  put_template_custom Pj "3d4224"
  put_template_custom Pk "e1dfce"
  put_template_custom Pl "e1dfce"
  put_template_custom Pm "1a1b0c"
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
