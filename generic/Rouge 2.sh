#!/bin/sh
# Rouge 2

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
put_template 0  "5d/5d/6b"
put_template 1  "c6/79/7e"
put_template 2  "96/9e/92"
put_template 3  "db/cd/ab"
put_template 4  "6e/94/b9"
put_template 5  "4c/4e/78"
put_template 6  "8a/b6/c1"
put_template 7  "e8/e8/ea"
put_template 8  "61/62/74"
put_template 9  "c6/79/7e"
put_template 10 "e6/dc/c4"
put_template 11 "e6/dc/c4"
put_template 12 "98/b3/cd"
put_template 13 "82/83/a1"
put_template 14 "ab/cb/d3"
put_template 15 "e8/e8/ea"

color_foreground="a2/a3/aa"
color_background="17/18/2b"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "a2a3aa"
  put_template_custom Ph "17182b"
  put_template_custom Pi "6e94b9"
  put_template_custom Pj "5d5d6b"
  put_template_custom Pk "dfe5ee"
  put_template_custom Pl "969e92"
  put_template_custom Pm "ffffff"
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
