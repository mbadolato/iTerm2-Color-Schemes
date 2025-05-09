#!/bin/sh
# rose-pine

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
put_template 0  "26/23/3a"
put_template 1  "eb/6f/92"
put_template 2  "31/74/8f"
put_template 3  "f6/c1/77"
put_template 4  "9c/cf/d8"
put_template 5  "c4/a7/e7"
put_template 6  "eb/bc/ba"
put_template 7  "e0/de/f4"
put_template 8  "6e/6a/86"
put_template 9  "eb/6f/92"
put_template 10 "31/74/8f"
put_template 11 "f6/c1/77"
put_template 12 "9c/cf/d8"
put_template 13 "c4/a7/e7"
put_template 14 "eb/bc/ba"
put_template 15 "e0/de/f4"

color_foreground="e0/de/f4"
color_background="19/17/24"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "e0def4"
  put_template_custom Ph "191724"
  put_template_custom Pi "e0def4"
  put_template_custom Pj "403d52"
  put_template_custom Pk "e0def4"
  put_template_custom Pl "e0def4"
  put_template_custom Pm "191724"
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
