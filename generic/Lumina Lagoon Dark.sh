#!/bin/sh
# Lumina Lagoon Dark

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
put_template 0  "1b/34/3c"
put_template 1  "df/73/70"
put_template 2  "8d/ce/a3"
put_template 3  "df/cc/78"
put_template 4  "a0/c7/f9"
put_template 5  "da/9e/f6"
put_template 6  "84/d3/dc"
put_template 7  "b4/c4/c9"
put_template 8  "85/9e/a7"
put_template 9  "eb/96/92"
put_template 10 "a7/e8/bc"
put_template 11 "fb/e6/8b"
put_template 12 "c8/e0/ff"
put_template 13 "ea/c1/ff"
put_template 14 "9d/ed/f7"
put_template 15 "d6/e7/ec"

color_foreground="d4/e5/ea"
color_background="18/2f/36"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "d4e5ea"
  put_template_custom Ph "182f36"
  put_template_custom Pi "d4e5ea"
  put_template_custom Pj "33525f"
  put_template_custom Pk "d4e5ea"
  put_template_custom Pl "d4e5ea"
  put_template_custom Pm "182f36"
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
