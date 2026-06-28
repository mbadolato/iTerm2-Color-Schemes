#!/bin/sh
# Amber CRT Retro

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
put_template 0  "2a/1e/00"
put_template 1  "ff/6a/00"
put_template 2  "ff/b0/00"
put_template 3  "ff/c7/42"
put_template 4  "ff/8c/00"
put_template 5  "ff/a0/33"
put_template 6  "ff/d2/7f"
put_template 7  "ff/d9/a0"
put_template 8  "6a/4e/00"
put_template 9  "ff/8a/1e"
put_template 10 "ff/c7/42"
put_template 11 "ff/e0/8a"
put_template 12 "ff/ab/3d"
put_template 13 "ff/c2/66"
put_template 14 "ff/e3/b0"
put_template 15 "ff/f0/d6"

color_foreground="ff/b0/00"
color_background="1a/12/00"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "ffb000"
  put_template_custom Ph "1a1200"
  put_template_custom Pi "ffb000"
  put_template_custom Pj "3a2a00"
  put_template_custom Pk "5a5240"
  put_template_custom Pl "ffb000"
  put_template_custom Pm "1a1200"
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
