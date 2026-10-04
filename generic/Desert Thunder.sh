#!/bin/sh
# Desert Thunder

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
put_template 0  "d0/d6/d5"
put_template 1  "f5/a0/8c"
put_template 2  "98/d9/ad"
put_template 3  "ee/d4/7d"
put_template 4  "a8/d2/f0"
put_template 5  "dc/b4/df"
put_template 6  "9d/e1/df"
put_template 7  "f5/f1/df"
put_template 8  "de/e3/e2"
put_template 9  "f9/b6/a5"
put_template 10 "b0/e3/bd"
put_template 11 "f6/e1/9a"
put_template 12 "c1/df/f4"
put_template 13 "e7/ca/e8"
put_template 14 "b9/eb/e8"
put_template 15 "ff/fd/f4"

color_foreground="f5/f1/df"
color_background="31/48/5a"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "f5f1df"
  put_template_custom Ph "31485a"
  put_template_custom Pi "9de5df"
  put_template_custom Pj "4d6475"
  put_template_custom Pk "fffbed"
  put_template_custom Pl "f4d06f"
  put_template_custom Pm "31485a"
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
