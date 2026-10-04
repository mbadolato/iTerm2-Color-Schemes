#!/bin/sh
# Prickly Pear

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
put_template 0  "cb/b8/c2"
put_template 1  "ff/8d/99"
put_template 2  "78/d5/8e"
put_template 3  "f5/c5/4e"
put_template 4  "9a/c4/ef"
put_template 5  "e4/9b/d2"
put_template 6  "7c/db/d5"
put_template 7  "ff/f0/df"
put_template 8  "db/cb/d2"
put_template 9  "ff/a8/b0"
put_template 10 "98/df/a6"
put_template 11 "f9/d7/78"
put_template 12 "b4/d5/f4"
put_template 13 "ed/b8/df"
put_template 14 "9c/e7/e2"
put_template 15 "ff/fa/f2"

color_foreground="ff/f0/df"
color_background="56/10/38"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "fff0df"
  put_template_custom Ph "561038"
  put_template_custom Pi "ffb92f"
  put_template_custom Pj "7b2853"
  put_template_custom Pk "fff7ed"
  put_template_custom Pl "f4c24f"
  put_template_custom Pm "561038"
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
