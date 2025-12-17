#!/bin/sh
# Onenord Light

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
put_template 0  "2e/34/40"
put_template 1  "cb/4f/53"
put_template 2  "48/a5/3d"
put_template 3  "ee/5e/25"
put_template 4  "38/79/c5"
put_template 5  "9f/4a/ca"
put_template 6  "3e/a1/ad"
put_template 7  "b2/b6/bd"
put_template 8  "64/6a/76"
put_template 9  "d1/63/66"
put_template 10 "5f/9e/9d"
put_template 11 "ba/79/3e"
put_template 12 "1b/40/a6"
put_template 13 "96/65/af"
put_template 14 "8f/bc/bb"
put_template 15 "ec/ef/f4"

color_foreground="2e/34/40"
color_background="f7/f8/fa"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "2e3440"
  put_template_custom Ph "f7f8fa"
  put_template_custom Pi "eceff4"
  put_template_custom Pj "eaebed"
  put_template_custom Pk "000000"
  put_template_custom Pl "3879c5"
  put_template_custom Pm "f7f8fa"
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
