#!/bin/sh
# flexoki-dark

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
put_template 0  "10/0f/0f"
put_template 1  "d1/4d/41"
put_template 2  "87/9a/39"
put_template 3  "d0/a2/15"
put_template 4  "43/85/be"
put_template 5  "ce/5d/97"
put_template 6  "3a/a9/9f"
put_template 7  "87/85/80"
put_template 8  "57/56/53"
put_template 9  "af/30/29"
put_template 10 "66/80/0b"
put_template 11 "ad/83/01"
put_template 12 "20/5e/a6"
put_template 13 "a0/2f/6f"
put_template 14 "24/83/7b"
put_template 15 "ce/cd/c3"

color_foreground="ce/cd/c3"
color_background="10/0f/0f"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "cecdc3"
  put_template_custom Ph "100f0f"
  put_template_custom Pi "fffcf0"
  put_template_custom Pj "cecdc3"
  put_template_custom Pk "100f0f"
  put_template_custom Pl "cecdc3"
  put_template_custom Pm "100f0f"
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
