#!/bin/sh
# moonfly

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
put_template 0  "32/34/37"
put_template 1  "ff/54/54"
put_template 2  "8c/c8/5f"
put_template 3  "e3/c7/8a"
put_template 4  "80/a0/ff"
put_template 5  "cf/87/e8"
put_template 6  "79/da/c8"
put_template 7  "c6/c6/c6"
put_template 8  "94/94/94"
put_template 9  "ff/51/89"
put_template 10 "36/c6/92"
put_template 11 "c6/c6/84"
put_template 12 "74/b2/ff"
put_template 13 "ae/81/ff"
put_template 14 "85/dc/85"
put_template 15 "e4/e4/e4"

color_foreground="bd/bd/bd"
color_background="08/08/08"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "bdbdbd"
  put_template_custom Ph "080808"
  put_template_custom Pi "eeeeee"
  put_template_custom Pj "b2ceee"
  put_template_custom Pk "080808"
  put_template_custom Pl "9e9e9e"
  put_template_custom Pm "080808"
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
