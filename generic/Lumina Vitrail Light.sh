#!/bin/sh
# Lumina Vitrail Light

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
put_template 0  "0f/14/1d"
put_template 1  "75/22/00"
put_template 2  "00/49/0f"
put_template 3  "7c/47/00"
put_template 4  "17/29/b2"
put_template 5  "62/12/7e"
put_template 6  "00/5b/72"
put_template 7  "6c/72/7e"
put_template 8  "5f/5e/54"
put_template 9  "58/17/00"
put_template 10 "00/34/08"
put_template 11 "62/37/00"
put_template 12 "12/24/7b"
put_template 13 "48/0d/5e"
put_template 14 "00/46/59"
put_template 15 "8b/92/9e"

color_foreground="0f/14/1d"
color_background="fc/fa/f4"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "0f141d"
  put_template_custom Ph "fcfaf4"
  put_template_custom Pi "0f141d"
  put_template_custom Pj "bac7e8"
  put_template_custom Pk "0f141d"
  put_template_custom Pl "0f141d"
  put_template_custom Pm "fcfaf4"
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
