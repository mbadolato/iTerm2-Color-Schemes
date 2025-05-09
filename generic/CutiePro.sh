#!/bin/sh
# CutiePro

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
put_template 0  "00/00/00"
put_template 1  "f5/6e/7f"
put_template 2  "be/c9/75"
put_template 3  "f5/86/69"
put_template 4  "42/d9/c5"
put_template 5  "d2/86/b7"
put_template 6  "37/cb/8a"
put_template 7  "d5/c3/c3"
put_template 8  "88/84/7f"
put_template 9  "e5/a1/a3"
put_template 10 "e8/d6/a7"
put_template 11 "f1/bb/79"
put_template 12 "80/c5/de"
put_template 13 "b2/94/bb"
put_template 14 "9d/cc/bb"
put_template 15 "ff/ff/ff"

color_foreground="d5/d0/c9"
color_background="18/18/18"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "d5d0c9"
  put_template_custom Ph "181818"
  put_template_custom Pi "d5d0c9"
  put_template_custom Pj "363636"
  put_template_custom Pk "d5d0c9"
  put_template_custom Pl "efc4cd"
  put_template_custom Pm "181818"
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
