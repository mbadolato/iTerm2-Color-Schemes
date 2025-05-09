#!/bin/sh
# Terminal Basic Dark

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
put_template 0  "00/00/00"
put_template 1  "c6/53/39"
put_template 2  "6a/c4/4b"
put_template 3  "b8/b7/4a"
put_template 4  "64/44/ed"
put_template 5  "d3/57/db"
put_template 6  "69/c1/cf"
put_template 7  "d1/d1/d1"
put_template 8  "90/90/90"
put_template 9  "eb/5a/3a"
put_template 10 "77/ea/51"
put_template 11 "ef/ef/53"
put_template 12 "d0/9a/f9"
put_template 13 "eb/5a/f7"
put_template 14 "78/f1/f2"
put_template 15 "ed/ed/ed"

color_foreground="ff/ff/ff"
color_background="1d/1e/1d"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "ffffff"
  put_template_custom Ph "1d1e1d"
  put_template_custom Pi "ffffff"
  put_template_custom Pj "3f638a"
  put_template_custom Pk "ffffff"
  put_template_custom Pl "9d9d9d"
  put_template_custom Pm "1d1e1d"
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
