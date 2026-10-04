#!/bin/sh
# Springfield Resident

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
put_template 0  "25/2b/32"
put_template 1  "b8/32/45"
put_template 2  "23/7a/3b"
put_template 3  "8a/5a/00"
put_template 4  "07/5a/a8"
put_template 5  "a9/2d/87"
put_template 6  "00/74/8a"
put_template 7  "5b/59/60"
put_template 8  "55/5a/61"
put_template 9  "c6/3d/4d"
put_template 10 "2b/82/43"
put_template 11 "76/50/00"
put_template 12 "12/67/b8"
put_template 13 "b3/37/92"
put_template 14 "00/7c/91"
put_template 15 "4a/4d/52"

color_foreground="08/4f/8f"
color_background="ff/dd/32"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "084f8f"
  put_template_custom Ph "ffdd32"
  put_template_custom Pi "075aa8"
  put_template_custom Pj "ef4fa8"
  put_template_custom Pk "24205f"
  put_template_custom Pl "1687e0"
  put_template_custom Pm "ffef73"
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
