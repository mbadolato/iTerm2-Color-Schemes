#!/bin/sh
# Carbon Paper

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
put_template 0  "2c/30/38"
put_template 1  "84/24/24"
put_template 2  "14/5a/37"
put_template 3  "65/4d/00"
put_template 4  "17/45/8b"
put_template 5  "60/31/87"
put_template 6  "00/58/66"
put_template 7  "3c/40/48"
put_template 8  "47/4b/53"
put_template 9  "90/2a/2a"
put_template 10 "18/5f/3d"
put_template 11 "6d/53/00"
put_template 12 "12/3a/78"
put_template 13 "67/39/8f"
put_template 14 "00/4b/57"
put_template 15 "45/49/51"

color_foreground="1d/20/28"
color_background="f8/f6/ed"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "1d2028"
  put_template_custom Ph "f8f6ed"
  put_template_custom Pi "294e8c"
  put_template_custom Pj "ddd9cb"
  put_template_custom Pk "1d2028"
  put_template_custom Pl "31558e"
  put_template_custom Pm "f8f6ed"
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
