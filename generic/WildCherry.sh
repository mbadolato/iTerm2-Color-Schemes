#!/bin/sh
# WildCherry

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
put_template 0  "00/05/07"
put_template 1  "d9/40/85"
put_template 2  "2a/b2/50"
put_template 3  "ff/d1/6f"
put_template 4  "88/3c/dc"
put_template 5  "ec/ec/ec"
put_template 6  "c1/b8/b7"
put_template 7  "ff/f8/de"
put_template 8  "00/9c/c9"
put_template 9  "da/6b/ac"
put_template 10 "f4/dc/a5"
put_template 11 "ea/c0/66"
put_template 12 "30/8c/ba"
put_template 13 "ae/63/6b"
put_template 14 "ff/91/9d"
put_template 15 "e4/83/8d"

color_foreground="da/fa/ff"
color_background="1f/17/26"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "dafaff"
  put_template_custom Ph "1f1726"
  put_template_custom Pi "819090"
  put_template_custom Pj "002831"
  put_template_custom Pk "e4ffff"
  put_template_custom Pl "dd00ff"
  put_template_custom Pm "ff00fe"
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
