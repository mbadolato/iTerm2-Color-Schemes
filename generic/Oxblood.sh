#!/bin/sh
# Oxblood

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
put_template 0  "23/14/17"
put_template 1  "ff/4d/54"
put_template 2  "c9/a2/4a"
put_template 3  "e0/b2/4a"
put_template 4  "d9/74/3f"
put_template 5  "e0/55/6b"
put_template 6  "e0/a3/6a"
put_template 7  "e8/d2/d4"
put_template 8  "7a/54/58"
put_template 9  "ff/68/6e"
put_template 10 "cf/ad/60"
put_template 11 "d9/74/3f"
put_template 12 "e8/6b/72"
put_template 13 "c8/32/4b"
put_template 14 "e4/ae/7c"
put_template 15 "ff/ff/ff"

color_foreground="e8/d2/d4"
color_background="14/0b/0d"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "e8d2d4"
  put_template_custom Ph "140b0d"
  put_template_custom Pi "e8d2d4"
  put_template_custom Pj "3a2227"
  put_template_custom Pk "60575a"
  put_template_custom Pl "e0483a"
  put_template_custom Pm "140b0d"
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
