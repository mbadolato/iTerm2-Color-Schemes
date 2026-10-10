#!/bin/sh
# Thirteen

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
put_template 0  "a9/9b/96"
put_template 1  "d9/7d/75"
put_template 2  "91/b9/94"
put_template 3  "c5/ad/70"
put_template 4  "84/9f/b4"
put_template 5  "aa/8d/a9"
put_template 6  "75/b3/a8"
put_template 7  "f4/ea/d8"
put_template 8  "be/b0/aa"
put_template 9  "e2/92/89"
put_template 10 "a6/c8/a8"
put_template 11 "d2/bd/86"
put_template 12 "9d/b5/c6"
put_template 13 "bb/a4/b9"
put_template 14 "91/c4/ba"
put_template 15 "ff/f8/eb"

color_foreground="f4/ea/d8"
color_background="26/06/07"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "f4ead8"
  put_template_custom Ph "260607"
  put_template_custom Pi "b7a26d"
  put_template_custom Pj "4b1719"
  put_template_custom Pk "fff7e9"
  put_template_custom Pl "d93035"
  put_template_custom Pm "260607"
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
