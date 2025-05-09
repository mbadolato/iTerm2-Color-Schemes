#!/bin/sh
# heeler

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
put_template 0  "00/00/00"
put_template 1  "d3/57/3b"
put_template 2  "c1/d0/41"
put_template 3  "ee/cf/75"
put_template 4  "6d/a3/ec"
put_template 5  "fd/9b/c1"
put_template 6  "fe/9d/6e"
put_template 7  "ff/ff/ff"
put_template 8  "00/00/00"
put_template 9  "d3/57/3b"
put_template 10 "c1/d0/41"
put_template 11 "ee/cf/75"
put_template 12 "2c/86/ff"
put_template 13 "fd/9b/c1"
put_template 14 "92/a5/df"
put_template 15 "ff/ff/ff"

color_foreground="fd/fd/fd"
color_background="21/1f/44"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "fdfdfd"
  put_template_custom Ph "211f44"
  put_template_custom Pi "414694"
  put_template_custom Pj "2b2c3f"
  put_template_custom Pk "7cfb70"
  put_template_custom Pl "ffffff"
  put_template_custom Pm "000000"
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
