#!/bin/sh
# IC_Orange_PPL

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
put_template 0  "00/00/00"
put_template 1  "c1/39/00"
put_template 2  "a4/a9/00"
put_template 3  "ca/af/00"
put_template 4  "bd/6d/00"
put_template 5  "fc/5e/00"
put_template 6  "f7/95/00"
put_template 7  "ff/c8/8a"
put_template 8  "6a/4f/2a"
put_template 9  "ff/8c/68"
put_template 10 "f6/ff/40"
put_template 11 "ff/e3/6e"
put_template 12 "ff/be/55"
put_template 13 "fc/87/4f"
put_template 14 "c6/97/52"
put_template 15 "fa/fa/ff"

color_foreground="ff/cb/83"
color_background="26/26/26"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "ffcb83"
  put_template_custom Ph "262626"
  put_template_custom Pi "fafaff"
  put_template_custom Pj "c14020"
  put_template_custom Pk "ffc88a"
  put_template_custom Pl "fc531d"
  put_template_custom Pm "ffc88a"
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
