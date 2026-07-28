#!/bin/sh
# Outrun Electric

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
put_template 0  "13/10/33"
put_template 1  "e6/1f/44"
put_template 2  "a7/da/1e"
put_template 3  "ff/d4/00"
put_template 4  "1e/a8/fc"
put_template 5  "ff/2a/fc"
put_template 6  "42/c6/ff"
put_template 7  "f2/f3/f7"
put_template 8  "54/6a/90"
put_template 9  "ef/6d/85"
put_template 10 "c6/e7/6d"
put_template 11 "ff/e3/59"
put_template 12 "6d/c6/fd"
put_template 13 "df/85/ff"
put_template 14 "84/da/ff"
put_template 15 "ff/ff/ff"

color_foreground="f2/f3/f7"
color_background="0c/0a/20"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "f2f3f7"
  put_template_custom Ph "0c0a20"
  put_template_custom Pi "f2f3f7"
  put_template_custom Pj "ba45a3"
  put_template_custom Pk "f2f3f7"
  put_template_custom Pl "ff2afc"
  put_template_custom Pm "0c0a20"
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
