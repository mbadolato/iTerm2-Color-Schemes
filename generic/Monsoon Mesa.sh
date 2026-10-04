#!/bin/sh
# Monsoon Mesa

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
put_template 0  "d0/d8/d6"
put_template 1  "f7/a1/8d"
put_template 2  "98/d9/ac"
put_template 3  "f0/d2/78"
put_template 4  "a7/d1/ef"
put_template 5  "df/b1/dc"
put_template 6  "9a/e1/de"
put_template 7  "f8/f1/df"
put_template 8  "de/e4/e2"
put_template 9  "fb/b7/a6"
put_template 10 "af/e3/bc"
put_template 11 "f7/e0/97"
put_template 12 "c0/de/f4"
put_template 13 "e9/c8/e7"
put_template 14 "b7/eb/e7"
put_template 15 "ff/fd/f4"

color_foreground="f8/f1/df"
color_background="16/4b/58"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "f8f1df"
  put_template_custom Ph "164b58"
  put_template_custom Pi "8ee2dc"
  put_template_custom Pj "356873"
  put_template_custom Pk "fffbed"
  put_template_custom Pl "f4c96a"
  put_template_custom Pm "164b58"
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
