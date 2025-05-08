#!/bin/sh
# Kolorit

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
put_template 0  "1d/1a/1e"
put_template 1  "ff/5b/82"
put_template 2  "47/d7/a1"
put_template 3  "e8/e5/62"
put_template 4  "5d/b4/ee"
put_template 5  "da/6c/da"
put_template 6  "57/e9/eb"
put_template 7  "ed/ed/ed"
put_template 8  "1d/1a/1e"
put_template 9  "ff/5b/82"
put_template 10 "47/d7/a1"
put_template 11 "e8/e5/62"
put_template 12 "5d/b4/ee"
put_template 13 "da/6c/da"
put_template 14 "57/e9/eb"
put_template 15 "ed/ed/ed"

color_foreground="ef/ec/ec"
color_background="1d/1a/1e"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "efecec"
  put_template_custom Ph "1d1a1e"
  put_template_custom Pi "ff5b82"
  put_template_custom Pj "e1925c"
  put_template_custom Pk "1d1a1e"
  put_template_custom Pl "c7c7c7"
  put_template_custom Pm "ffffff"
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
