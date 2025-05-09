#!/bin/sh
# DoomOne

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
put_template 1  "ff/6c/6b"
put_template 2  "98/be/65"
put_template 3  "ec/be/7b"
put_template 4  "a9/a1/e1"
put_template 5  "c6/78/dd"
put_template 6  "51/af/ef"
put_template 7  "bb/c2/cf"
put_template 8  "00/00/00"
put_template 9  "ff/66/55"
put_template 10 "99/bb/66"
put_template 11 "ec/be/7b"
put_template 12 "a9/a1/e1"
put_template 13 "c6/78/dd"
put_template 14 "51/af/ef"
put_template 15 "bf/bf/bf"

color_foreground="bb/c2/cf"
color_background="28/2c/34"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "bbc2cf"
  put_template_custom Ph "282c34"
  put_template_custom Pi "bbc2cf"
  put_template_custom Pj "42444b"
  put_template_custom Pk "bbc2cf"
  put_template_custom Pl "51afef"
  put_template_custom Pm "1b1b1b"
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
