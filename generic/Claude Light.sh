#!/bin/sh
# Claude Light

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
put_template 0  "0a/0a/0a"
put_template 1  "a8/4b/3a"
put_template 2  "2e/7c/4c"
put_template 3  "8a/62/20"
put_template 4  "18/4e/95"
put_template 5  "88/2b/4d"
put_template 6  "06/60/49"
put_template 7  "b6/b5/aa"
put_template 8  "51/50/4d"
put_template 9  "e3/4a/4a"
put_template 10 "63/99/00"
put_template 11 "b8/77/00"
put_template 12 "38/86/e5"
put_template 13 "d5/53/82"
put_template 14 "19/9f/70"
put_template 15 "e2/e1/da"

color_foreground="14/14/13"
color_background="fa/f9/f5"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "141413"
  put_template_custom Ph "faf9f5"
  put_template_custom Pi "141413"
  put_template_custom Pj "f0eee6"
  put_template_custom Pk "141413"
  put_template_custom Pl "d97757"
  put_template_custom Pm "faf9f5"
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
