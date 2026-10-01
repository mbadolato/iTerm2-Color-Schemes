#!/bin/sh
# Black Box Recorder

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
put_template 0  "b9/b7/b0"
put_template 1  "ff/80/6d"
put_template 2  "78/d1/9d"
put_template 3  "f1/ca/63"
put_template 4  "8c/b2/ed"
put_template 5  "d5/a0/e6"
put_template 6  "80/d3/dc"
put_template 7  "f4/f1/e8"
put_template 8  "cb/c8/c0"
put_template 9  "ff/9c/8b"
put_template 10 "99/de/b5"
put_template 11 "f7/db/86"
put_template 12 "aa/c7/f3"
put_template 13 "e4/b9/ed"
put_template 14 "a1/e1/e7"
put_template 15 "ff/fd/f7"

color_foreground="f4/f1/e8"
color_background="05/06/08"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "f4f1e8"
  put_template_custom Ph "050608"
  put_template_custom Pi "ffb000"
  put_template_custom Pj "2b2414"
  put_template_custom Pk "fff8e7"
  put_template_custom Pl "ffcc33"
  put_template_custom Pm "050608"
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
