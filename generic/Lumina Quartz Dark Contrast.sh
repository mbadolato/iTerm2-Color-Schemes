#!/bin/sh
# Lumina Quartz Dark Contrast

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
put_template 0  "11/12/13"
put_template 1  "ff/a6/9b"
put_template 2  "62/d1/7f"
put_template 3  "ff/c3/34"
put_template 4  "7f/b7/ff"
put_template 5  "ec/8c/e4"
put_template 6  "00/e2/fc"
put_template 7  "ca/ce/d1"
put_template 8  "8c/94/9a"
put_template 9  "ff/cd/c6"
put_template 10 "7e/eb/98"
put_template 11 "ff/e4/b0"
put_template 12 "ad/d1/ff"
put_template 13 "ff/ad/f7"
put_template 14 "a6/f2/ff"
put_template 15 "eb/ef/f2"

color_foreground="eb/ef/f2"
color_background="0d/0e/0f"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "ebeff2"
  put_template_custom Ph "0d0e0f"
  put_template_custom Pi "ebeff2"
  put_template_custom Pj "1d3d43"
  put_template_custom Pk "ebeff2"
  put_template_custom Pl "ebeff2"
  put_template_custom Pm "0d0e0f"
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
