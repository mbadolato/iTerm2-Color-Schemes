#!/bin/sh
# Rainbows and Unicorns Paper White

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
put_template 0  "1b/1b/1f"
put_template 1  "c2/27/2d"
put_template 2  "2f/7d/1f"
put_template 3  "8a/61/00"
put_template 4  "0b/6f/a6"
put_template 5  "8a/2f/8c"
put_template 6  "0b/7f/78"
put_template 7  "5e/5d/58"
put_template 8  "8b/8a/84"
put_template 9  "b0/4e/00"
put_template 10 "33/85/1f"
put_template 11 "94/6a/00"
put_template 12 "12/79/b5"
put_template 13 "a8/42/9f"
put_template 14 "0b/80/7a"
put_template 15 "ff/ff/ff"

color_foreground="1b/1b/1f"
color_background="ef/ed/e6"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "1b1b1f"
  put_template_custom Ph "efede6"
  put_template_custom Pi "1b1b1f"
  put_template_custom Pj "1b1b1f"
  put_template_custom Pk "efede6"
  put_template_custom Pl "1b1b1f"
  put_template_custom Pm "efede6"
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
