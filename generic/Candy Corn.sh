#!/bin/sh
# Candy Corn

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
put_template 0  "32/2b/24"
put_template 1  "9b/2f/12"
put_template 2  "46/61/2d"
put_template 3  "78/57/11"
put_template 4  "36/51/6b"
put_template 5  "69/41/6e"
put_template 6  "28/65/6a"
put_template 7  "51/46/3b"
put_template 8  "29/23/1e"
put_template 9  "7f/27/0f"
put_template 10 "39/50/25"
put_template 11 "62/47/0e"
put_template 12 "2c/42/58"
put_template 13 "56/35/5a"
put_template 14 "21/53/57"
put_template 15 "42/39/30"

color_foreground="51/46/3b"
color_background="ff/f0/d2"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "51463b"
  put_template_custom Ph "fff0d2"
  put_template_custom Pi "62470e"
  put_template_custom Pj "f6c89b"
  put_template_custom Pk "24150e"
  put_template_custom Pl "24150e"
  put_template_custom Pm "fff0d2"
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
