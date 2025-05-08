#!/bin/sh
# SeaShells

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
put_template 0  "17/38/4c"
put_template 1  "d1/51/23"
put_template 2  "02/7c/9b"
put_template 3  "fc/a0/2f"
put_template 4  "1e/49/50"
put_template 5  "68/d4/f1"
put_template 6  "50/a3/b5"
put_template 7  "de/b8/8d"
put_template 8  "43/4b/53"
put_template 9  "d4/86/78"
put_template 10 "62/8d/98"
put_template 11 "fd/d3/9f"
put_template 12 "1b/bc/dd"
put_template 13 "bb/e3/ee"
put_template 14 "87/ac/b4"
put_template 15 "fe/e4/ce"

color_foreground="de/b8/8d"
color_background="09/14/1b"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "deb88d"
  put_template_custom Ph "09141b"
  put_template_custom Pi "ffe4cc"
  put_template_custom Pj "1e4962"
  put_template_custom Pk "fee4ce"
  put_template_custom Pl "fca02f"
  put_template_custom Pm "08131a"
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
