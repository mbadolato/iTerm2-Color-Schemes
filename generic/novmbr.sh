#!/bin/sh
# novmbr

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
put_template 0  "28/2a/2e"
put_template 1  "9f/64/34"
put_template 2  "9d/ac/5f"
put_template 3  "cc/a7/5f"
put_template 4  "2f/7d/7c"
put_template 5  "b5/89/6e"
put_template 6  "52/87/7f"
put_template 7  "c7/b8/ac"
put_template 8  "5d/4e/47"
put_template 9  "9f/64/34"
put_template 10 "9d/ac/5f"
put_template 11 "cc/a7/5f"
put_template 12 "2f/7d/7c"
put_template 13 "b5/89/6e"
put_template 14 "52/87/7f"
put_template 15 "c7/b8/ac"

color_foreground="c7/b8/ac"
color_background="24/1d/1a"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "c7b8ac"
  put_template_custom Ph "241d1a"
  put_template_custom Pi "c7b8ac"
  put_template_custom Pj "241d1a"
  put_template_custom Pk "c7b8ac"
  put_template_custom Pl "c7b8ac"
  put_template_custom Pm "241d1a"
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
