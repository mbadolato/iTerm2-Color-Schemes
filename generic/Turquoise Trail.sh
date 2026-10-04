#!/bin/sh
# Turquoise Trail

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
put_template 0  "d0/d9/d2"
put_template 1  "ff/ad/8e"
put_template 2  "a7/df/ae"
put_template 3  "f7/d8/79"
put_template 4  "b1/d6/f4"
put_template 5  "ef/b0/d2"
put_template 6  "a9/e5/df"
put_template 7  "ff/f0/d5"
put_template 8  "e0/e5/df"
put_template 9  "ff/c0/a5"
put_template 10 "bc/e8/c2"
put_template 11 "ff/e4/93"
put_template 12 "c8/e3/f7"
put_template 13 "f4/c6/df"
put_template 14 "c5/ee/e9"
put_template 15 "ff/fa/f0"

color_foreground="ff/f0/d5"
color_background="07/51/53"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "fff0d5"
  put_template_custom Ph "075153"
  put_template_custom Pi "ffc56a"
  put_template_custom Pj "287071"
  put_template_custom Pk "fff8e8"
  put_template_custom Pl "ffb34f"
  put_template_custom Pm "063d3f"
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
