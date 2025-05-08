#!/bin/sh
# selenized-dark

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
put_template 0  "18/49/56"
put_template 1  "fa/57/50"
put_template 2  "75/b9/38"
put_template 3  "db/b3/2d"
put_template 4  "46/95/f7"
put_template 5  "f2/75/be"
put_template 6  "41/c7/b9"
put_template 7  "72/89/8f"
put_template 8  "2d/5b/69"
put_template 9  "ff/66/5c"
put_template 10 "84/c7/47"
put_template 11 "eb/c1/3d"
put_template 12 "58/a3/ff"
put_template 13 "ff/84/cd"
put_template 14 "53/d6/c7"
put_template 15 "ca/d8/d9"

color_foreground="ad/bc/bc"
color_background="10/3c/48"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "adbcbc"
  put_template_custom Ph "103c48"
  put_template_custom Pi "adbcbc"
  put_template_custom Pj "184956"
  put_template_custom Pk "53d6c7"
  put_template_custom Pl "adbcbc"
  put_template_custom Pm "adbcbc"
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
