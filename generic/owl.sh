#!/bin/sh
# owl

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
put_template 0  "30/2c/2c"
put_template 1  "5a/5a/5a"
put_template 2  "98/98/98"
put_template 3  "ca/ca/ca"
put_template 4  "65/65/65"
put_template 5  "b1/b1/b1"
put_template 6  "7f/7f/7f"
put_template 7  "de/de/de"
put_template 8  "5d/59/5b"
put_template 9  "da/5b/2c"
put_template 10 "98/98/98"
put_template 11 "ca/ca/ca"
put_template 12 "65/65/65"
put_template 13 "b1/b1/b1"
put_template 14 "7f/7f/7f"
put_template 15 "ff/ff/ff"

color_foreground="de/de/de"
color_background="2f/2b/2c"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "dedede"
  put_template_custom Ph "2f2b2c"
  put_template_custom Pi "dedede"
  put_template_custom Pj "dedede"
  put_template_custom Pk "2f2b2c"
  put_template_custom Pl "dedede"
  put_template_custom Pm "2f2b2c"
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
