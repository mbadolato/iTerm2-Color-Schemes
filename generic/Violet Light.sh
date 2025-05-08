#!/bin/sh
# Violet Light

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
put_template 0  "56/59/5c"
put_template 1  "c9/4c/22"
put_template 2  "85/98/1c"
put_template 3  "b4/88/1d"
put_template 4  "2e/8b/ce"
put_template 5  "d1/3a/82"
put_template 6  "32/a1/98"
put_template 7  "d3/d0/c9"
put_template 8  "45/48/4b"
put_template 9  "bd/36/13"
put_template 10 "73/8a/04"
put_template 11 "a5/77/05"
put_template 12 "21/76/c7"
put_template 13 "c6/1c/6f"
put_template 14 "25/92/86"
put_template 15 "c9/c6/bd"

color_foreground="53/68/70"
color_background="fc/f4/dc"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "536870"
  put_template_custom Ph "fcf4dc"
  put_template_custom Pi "475b62"
  put_template_custom Pj "595ab7"
  put_template_custom Pk "fcf4dc"
  put_template_custom Pl "536870"
  put_template_custom Pm "fcf4dc"
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
