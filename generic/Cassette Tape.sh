#!/bin/sh
# Cassette Tape

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
put_template 0  "51/43/39"
put_template 1  "b9/1c/1c"
put_template 2  "3f/62/12"
put_template 3  "be/12/3c"
put_template 4  "7c/2d/12"
put_template 5  "0f/76/6e"
put_template 6  "b4/53/09"
put_template 7  "6b/4f/3f"
put_template 8  "c4/b3/9a"
put_template 9  "94/16/16"
put_template 10 "32/4e/0e"
put_template 11 "9c/0f/31"
put_template 12 "63/24/0e"
put_template 13 "0c/5e/58"
put_template 14 "90/42/07"
put_template 15 "2b/1b/12"

color_foreground="2b/1b/12"
color_background="ff/f7/ed"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "2b1b12"
  put_template_custom Ph "fff7ed"
  put_template_custom Pi "2b1b12"
  put_template_custom Pj "2b1b12"
  put_template_custom Pk "fff7ed"
  put_template_custom Pl "2b1b12"
  put_template_custom Pm "fff7ed"
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
