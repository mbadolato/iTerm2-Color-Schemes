#!/bin/sh
# Trick or Treat

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
put_template 0  "bb/ae/c8"
put_template 1  "ff/8b/82"
put_template 2  "a8/dc/72"
put_template 3  "f8/c9/4e"
put_template 4  "8f/c9/f2"
put_template 5  "e7/8b/d8"
put_template 6  "78/dc/e1"
put_template 7  "ff/f0/e3"
put_template 8  "ce/c1/da"
put_template 9  "ff/a5/a0"
put_template 10 "bd/e8/8d"
put_template 11 "fb/dc/72"
put_template 12 "ac/d9/f7"
put_template 13 "ef/aa/e3"
put_template 14 "99/e7/ea"
put_template 15 "ff/fa/f2"

color_foreground="ff/f0/e3"
color_background="40/14/5f"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "fff0e3"
  put_template_custom Ph "40145f"
  put_template_custom Pi "ffbd38"
  put_template_custom Pj "642b82"
  put_template_custom Pk "fff9f0"
  put_template_custom Pl "ff65bd"
  put_template_custom Pm "40145f"
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
