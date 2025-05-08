#!/bin/sh
# xcodedark

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
put_template 0  "41/44/53"
put_template 1  "ff/81/70"
put_template 2  "78/c2/b3"
put_template 3  "d9/c9/7c"
put_template 4  "4e/b0/cc"
put_template 5  "ff/7a/b2"
put_template 6  "b2/81/eb"
put_template 7  "df/df/e0"
put_template 8  "7f/8c/98"
put_template 9  "ff/81/70"
put_template 10 "ac/f2/e4"
put_template 11 "ff/a1/4f"
put_template 12 "6b/df/ff"
put_template 13 "ff/7a/b2"
put_template 14 "da/ba/ff"
put_template 15 "df/df/e0"

color_foreground="df/df/e0"
color_background="29/2a/30"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "dfdfe0"
  put_template_custom Ph "292a30"
  put_template_custom Pi "dfdfe0"
  put_template_custom Pj "414453"
  put_template_custom Pk "dfdfe0"
  put_template_custom Pl "dfdfe0"
  put_template_custom Pm "292a30"
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
