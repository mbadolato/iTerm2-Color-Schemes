#!/bin/sh
# Lumina Olive Dark

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
put_template 0  "26/28/14"
put_template 1  "cd/6f/71"
put_template 2  "9a/cc/a4"
put_template 3  "ed/ba/7a"
put_template 4  "8f/b9/f7"
put_template 5  "dd/ab/d8"
put_template 6  "8a/cb/d2"
put_template 7  "bf/bd/ae"
put_template 8  "8a/8b/76"
put_template 9  "da/90/90"
put_template 10 "b2/e7/bd"
put_template 11 "ff/d7/a6"
put_template 12 "b5/d3/ff"
put_template 13 "f8/c4/f3"
put_template 14 "a2/e5/ed"
put_template 15 "df/dd/ce"

color_foreground="df/dd/ce"
color_background="21/23/11"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "dfddce"
  put_template_custom Ph "212311"
  put_template_custom Pi "dfddce"
  put_template_custom Pj "454343"
  put_template_custom Pk "dfddce"
  put_template_custom Pl "dfddce"
  put_template_custom Pm "212311"
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
