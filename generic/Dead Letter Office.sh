#!/bin/sh
# Dead Letter Office

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
put_template 0  "b8/c1/cc"
put_template 1  "ff/81/78"
put_template 2  "79/d5/a7"
put_template 3  "ff/d3/6a"
put_template 4  "88/b6/ff"
put_template 5  "dc/a5/ff"
put_template 6  "83/dc/e5"
put_template 7  "ee/f2/f6"
put_template 8  "cb/d2/da"
put_template 9  "ff/9b/94"
put_template 10 "9a/e2/bd"
put_template 11 "ff/e1/8c"
put_template 12 "a9/ca/ff"
put_template 13 "e8/be/ff"
put_template 14 "a4/e9/ef"
put_template 15 "ff/ff/ff"

color_foreground="ee/f2/f6"
color_background="09/0d/12"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "eef2f6"
  put_template_custom Ph "090d12"
  put_template_custom Pi "ffb36b"
  put_template_custom Pj "26313d"
  put_template_custom Pk "f7fafc"
  put_template_custom Pl "8fc7ff"
  put_template_custom Pm "090d12"
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
