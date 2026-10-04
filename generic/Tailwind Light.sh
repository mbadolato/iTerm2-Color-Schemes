#!/bin/sh
# Tailwind Light

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
put_template 0  "26/26/26"
put_template 1  "b9/1c/1c"
put_template 2  "15/80/3d"
put_template 3  "a1/62/07"
put_template 4  "03/69/a1"
put_template 5  "a2/1c/af"
put_template 6  "0f/76/6e"
put_template 7  "ba/ba/ba"
put_template 8  "73/73/73"
put_template 9  "dc/26/26"
put_template 10 "16/a3/4a"
put_template 11 "ca/8a/04"
put_template 12 "02/84/c7"
put_template 13 "c0/26/d3"
put_template 14 "0d/94/88"
put_template 15 "e5/e5/e5"

color_foreground="0a/0a/0a"
color_background="fa/fa/fa"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "0a0a0a"
  put_template_custom Ph "fafafa"
  put_template_custom Pi "0a0a0a"
  put_template_custom Pj "e2e8f0"
  put_template_custom Pk "0a0a0a"
  put_template_custom Pl "0a0a0a"
  put_template_custom Pm "fafafa"
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
