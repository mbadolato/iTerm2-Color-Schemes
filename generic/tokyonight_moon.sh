#!/bin/sh
# tokyonight_moon

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
put_template 0  "1b/1d/2b"
put_template 1  "ff/75/7f"
put_template 2  "c3/e8/8d"
put_template 3  "ff/c7/77"
put_template 4  "82/aa/ff"
put_template 5  "c0/99/ff"
put_template 6  "86/e1/fc"
put_template 7  "82/8b/b8"
put_template 8  "44/4a/73"
put_template 9  "ff/75/7f"
put_template 10 "c3/e8/8d"
put_template 11 "ff/c7/77"
put_template 12 "82/aa/ff"
put_template 13 "c0/99/ff"
put_template 14 "86/e1/fc"
put_template 15 "c8/d3/f5"

color_foreground="c8/d3/f5"
color_background="22/24/36"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "c8d3f5"
  put_template_custom Ph "222436"
  put_template_custom Pi "4fd6be"
  put_template_custom Pj "2d3f76"
  put_template_custom Pk "c8d3f5"
  put_template_custom Pl "c8d3f5"
  put_template_custom Pm "222436"
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
