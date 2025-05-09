#!/bin/sh
# IR_Black

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
put_template 0  "4f/4f/4f"
put_template 1  "fa/6c/60"
put_template 2  "a8/ff/60"
put_template 3  "ff/fe/b7"
put_template 4  "96/ca/fe"
put_template 5  "fa/73/fd"
put_template 6  "c6/c5/fe"
put_template 7  "ef/ed/ef"
put_template 8  "7b/7b/7b"
put_template 9  "fc/b6/b0"
put_template 10 "cf/ff/ab"
put_template 11 "ff/ff/cc"
put_template 12 "b5/dc/ff"
put_template 13 "fb/9c/fe"
put_template 14 "e0/e0/fe"
put_template 15 "ff/ff/ff"

color_foreground="f1/f1/f1"
color_background="00/00/00"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "f1f1f1"
  put_template_custom Ph "000000"
  put_template_custom Pi "ffffff"
  put_template_custom Pj "b5d5ff"
  put_template_custom Pk "000000"
  put_template_custom Pl "808080"
  put_template_custom Pm "ffffff"
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
