#!/bin/sh
# Night Pharmacy

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
put_template 0  "af/be/b5"
put_template 1  "ef/80/88"
put_template 2  "72/d1/a0"
put_template 3  "e6/cb/69"
put_template 4  "83/b3/e7"
put_template 5  "cb/a0/df"
put_template 6  "72/d3/d0"
put_template 7  "ec/f5/ef"
put_template 8  "c4/d0/c9"
put_template 9  "f1/9b/a1"
put_template 10 "91/df/b7"
put_template 11 "ed/db/8b"
put_template 12 "a3/c8/ef"
put_template 13 "da/bb/e8"
put_template 14 "94/e2/df"
put_template 15 "ff/ff/ff"

color_foreground="ec/f5/ef"
color_background="07/10/0b"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "ecf5ef"
  put_template_custom Ph "07100b"
  put_template_custom Pi "6fe7a5"
  put_template_custom Pj "173425"
  put_template_custom Pk "f5fff8"
  put_template_custom Pl "7ff0bd"
  put_template_custom Pm "07100b"
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
