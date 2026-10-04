#!/bin/sh
# Canyon Shadow

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
put_template 0  "d5/cc/d3"
put_template 1  "fb/a4/93"
put_template 2  "9b/d7/ad"
put_template 3  "f0/d1/76"
put_template 4  "a1/cb/ed"
put_template 5  "e5/b1/dc"
put_template 6  "96/df/da"
put_template 7  "ff/f0/df"
put_template 8  "e2/da/e0"
put_template 9  "ff/b8/a8"
put_template 10 "b1/e1/bc"
put_template 11 "f8/df/94"
put_template 12 "bb/da/f2"
put_template 13 "ed/c5/e5"
put_template 14 "b4/ea/e5"
put_template 15 "ff/fa/f3"

color_foreground="ff/f0/df"
color_background="51/35/54"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "fff0df"
  put_template_custom Ph "513554"
  put_template_custom Pi "f4b96d"
  put_template_custom Pj "6e5270"
  put_template_custom Pk "fff8ed"
  put_template_custom Pl "f5c15e"
  put_template_custom Pm "513554"
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
