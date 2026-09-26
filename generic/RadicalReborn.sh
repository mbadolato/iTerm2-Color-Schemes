#!/bin/sh
# RadicalReborn

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
put_template 0  "30/31/7d"
put_template 1  "ff/53/95"
put_template 2  "d8/ff/4e"
put_template 3  "ff/fc/7e"
put_template 4  "7d/d9/e4"
put_template 5  "fa/61/b8"
put_template 6  "a8/ff/ef"
put_template 7  "cf/f0/e8"
put_template 8  "46/27/c2"
put_template 9  "ff/42/7b"
put_template 10 "c8/ff/00"
put_template 11 "f8/d8/46"
put_template 12 "84/f9/fe"
put_template 13 "d5/35/8f"
put_template 14 "83/fe/e8"
put_template 15 "cb/ff/f2"

color_foreground="de/ff/f7"
color_background="14/13/22"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "defff7"
  put_template_custom Ph "141322"
  put_template_custom Pi "d3e5e1"
  put_template_custom Pj "3c2e61"
  put_template_custom Pk "eec1c1"
  put_template_custom Pl "ff428e"
  put_template_custom Pm "defff7"
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
