#!/bin/sh
# Opaline

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
put_template 0  "20/1b/33"
put_template 1  "ff/6b/92"
put_template 2  "86/e6/b4"
put_template 3  "ff/c2/ae"
put_template 4  "8f/b4/ff"
put_template 5  "be/9b/ff"
put_template 6  "5f/e3/d8"
put_template 7  "ec/e9/f7"
put_template 8  "6b/67/8f"
put_template 9  "ff/81/a2"
put_template 10 "95/e9/bd"
put_template 11 "f4/d2/7e"
put_template 12 "b7/9b/ff"
put_template 13 "ff/9e/d2"
put_template 14 "72/e6/dd"
put_template 15 "ff/ff/ff"

color_foreground="ec/e9/f7"
color_background="13/11/21"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "ece9f7"
  put_template_custom Ph "131121"
  put_template_custom Pi "ece9f7"
  put_template_custom Pj "2c2748"
  put_template_custom Pk "535161"
  put_template_custom Pl "ffb3d6"
  put_template_custom Pm "131121"
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
