#!/bin/sh
# Stardust Voltage

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
put_template 0  "68/5c/59"
put_template 1  "89/2c/3e"
put_template 2  "34/6c/51"
put_template 3  "74/54/18"
put_template 4  "27/49/88"
put_template 5  "68/43/76"
put_template 6  "2b/66/6f"
put_template 7  "27/35/4e"
put_template 8  "53/4a/47"
put_template 9  "79/27/37"
put_template 10 "2e/5f/47"
put_template 11 "66/4a/15"
put_template 12 "22/40/78"
put_template 13 "5c/3b/68"
put_template 14 "26/5a/62"
put_template 15 "1f/2a/3e"

color_foreground="27/35/4e"
color_background="f0/e5/d9"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "27354e"
  put_template_custom Ph "f0e5d9"
  put_template_custom Pi "1f2a3e"
  put_template_custom Pj "dbc6c4"
  put_template_custom Pk "27354e"
  put_template_custom Pl "664a15"
  put_template_custom Pm "f0e5d9"
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
