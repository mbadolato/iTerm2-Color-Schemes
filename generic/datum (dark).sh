#!/bin/sh
# datum (dark)

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
put_template 0  "2b/2f/35"
put_template 1  "ef/84/4a"
put_template 2  "51/da/a7"
put_template 3  "d8/cf/58"
put_template 4  "66/b6/f4"
put_template 5  "db/78/b1"
put_template 6  "5d/da/e0"
put_template 7  "db/e0/e8"
put_template 8  "8f/98/a3"
put_template 9  "e6/ac/4c"
put_template 10 "51/da/a7"
put_template 11 "fc/dc/ad"
put_template 12 "b2/da/fb"
put_template 13 "f5/b9/d9"
put_template 14 "a5/f5/f9"
put_template 15 "ee/f2/f7"

color_foreground="db/e0/e8"
color_background="0f/13/18"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "dbe0e8"
  put_template_custom Ph "0f1318"
  put_template_custom Pi "dbe0e8"
  put_template_custom Pj "2b2f35"
  put_template_custom Pk "dbe0e8"
  put_template_custom Pl "db78b1"
  put_template_custom Pm "0f1318"
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
