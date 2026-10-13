#!/bin/sh
# 5150 Mode

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
put_template 0  "8c/a9/9f"
put_template 1  "d5/9a/71"
put_template 2  "70/bd/83"
put_template 3  "d2/ca/72"
put_template 4  "80/b3/a0"
put_template 5  "a8/b3/8a"
put_template 6  "62/c5/ac"
put_template 7  "e5/ed/db"
put_template 8  "a8/c5/b9"
put_template 9  "e8/ab/83"
put_template 10 "8e/d6/9a"
put_template 11 "e3/dc/8b"
put_template 12 "9b/c8/b5"
put_template 13 "be/c7/a0"
put_template 14 "7d/db/c2"
put_template 15 "ff/ff/ff"

color_foreground="ec/f4/db"
color_background="08/28/20"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "ecf4db"
  put_template_custom Ph "082820"
  put_template_custom Pi "ffffff"
  put_template_custom Pj "245444"
  put_template_custom Pk "ffffff"
  put_template_custom Pl "d5e875"
  put_template_custom Pm "082820"
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
