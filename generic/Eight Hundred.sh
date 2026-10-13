#!/bin/sh
# Eight Hundred

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
put_template 0  "b2/c0/c9"
put_template 1  "f0/8b/81"
put_template 2  "8e/d1/a3"
put_template 3  "f3/c7/6c"
put_template 4  "8b/b9/ea"
put_template 5  "c4/a2/e6"
put_template 6  "69/d9/cb"
put_template 7  "e9/e6/d9"
put_template 8  "d1/d9/de"
put_template 9  "ff/a6/9b"
put_template 10 "a9/e0/b9"
put_template 11 "ff/e0/9a"
put_template 12 "aa/cd/f3"
put_template 13 "d8/bc/ee"
put_template 14 "91/e8/dd"
put_template 15 "ff/ff/ff"

color_foreground="e9/e6/d9"
color_background="10/1c/28"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "e9e6d9"
  put_template_custom Ph "101c28"
  put_template_custom Pi "ffffff"
  put_template_custom Pj "395468"
  put_template_custom Pk "ffffff"
  put_template_custom Pl "f3c76c"
  put_template_custom Pm "101c28"
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
