#!/bin/sh
# Green Screen

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
put_template 0  "a9/bd/b0"
put_template 1  "ed/80/87"
put_template 2  "70/d1/9c"
put_template 3  "e5/cc/69"
put_template 4  "82/b3/e7"
put_template 5  "c9/9f/df"
put_template 6  "70/d2/ce"
put_template 7  "df/f7/e8"
put_template 8  "c0/ce/c5"
put_template 9  "f0/9b/a1"
put_template 10 "90/df/b4"
put_template 11 "ec/dc/8b"
put_template 12 "a1/c8/ef"
put_template 13 "d9/ba/e8"
put_template 14 "92/e1/dc"
put_template 15 "f6/ff/f9"

color_foreground="df/f7/e8"
color_background="03/10/09"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "dff7e8"
  put_template_custom Ph "031009"
  put_template_custom Pi "79e7a7"
  put_template_custom Pj "12351f"
  put_template_custom Pk "effff4"
  put_template_custom Pl "8af0b4"
  put_template_custom Pm "031009"
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
