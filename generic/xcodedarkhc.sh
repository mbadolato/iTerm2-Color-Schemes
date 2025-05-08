#!/bin/sh
# xcodedarkhc

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
put_template 0  "43/45/4b"
put_template 1  "ff/8a/7a"
put_template 2  "83/c9/bc"
put_template 3  "d9/c6/68"
put_template 4  "4e/c4/e6"
put_template 5  "ff/85/b8"
put_template 6  "cd/a1/ff"
put_template 7  "ff/ff/ff"
put_template 8  "83/89/91"
put_template 9  "ff/8a/7a"
put_template 10 "b1/fa/eb"
put_template 11 "ff/a1/4f"
put_template 12 "6b/df/ff"
put_template 13 "ff/85/b8"
put_template 14 "e5/cf/ff"
put_template 15 "ff/ff/ff"

color_foreground="ff/ff/ff"
color_background="1f/1f/24"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "ffffff"
  put_template_custom Ph "1f1f24"
  put_template_custom Pi "ffffff"
  put_template_custom Pj "43454b"
  put_template_custom Pk "ffffff"
  put_template_custom Pl "ffffff"
  put_template_custom Pm "1f1f24"
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
