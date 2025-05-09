#!/bin/sh
# Dark Modern

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
put_template 0  "27/27/27"
put_template 1  "f7/49/49"
put_template 2  "2e/a0/43"
put_template 3  "9e/6a/03"
put_template 4  "00/78/d4"
put_template 5  "d0/12/73"
put_template 6  "1d/b4/d6"
put_template 7  "cc/cc/cc"
put_template 8  "5d/5d/5d"
put_template 9  "dc/54/52"
put_template 10 "23/d1/8b"
put_template 11 "f5/f5/43"
put_template 12 "3b/8e/ea"
put_template 13 "d6/70/d6"
put_template 14 "29/b8/db"
put_template 15 "e5/e5/e5"

color_foreground="cc/cc/cc"
color_background="1f/1f/1f"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "cccccc"
  put_template_custom Ph "1f1f1f"
  put_template_custom Pi "ffffff"
  put_template_custom Pj "3a3d41"
  put_template_custom Pk "e0e0e0"
  put_template_custom Pl "ffffff"
  put_template_custom Pm "000000"
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
