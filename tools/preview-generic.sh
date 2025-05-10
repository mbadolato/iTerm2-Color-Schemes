#!/bin/bash

if [ $# -eq 0 ]; then
  echo "Usage: $0 [theme files]"
  echo "Example: $0 generic/*Light*.sh"
  exit 1
fi

themes=("$@")
total=${#themes[@]}

if [ $total -eq 0 ]; then
  echo "No theme files found."
  exit 1
fi

current=0

show_theme_info() {
  # Move cursor to beginning of line
  echo -en "\r\033[K"
  echo -en "\033[1;36m>> Theme $((current+1))/$total: $(basename "${themes[$current]}") | ← → to navigate | q to quit\033[0m"
}

execute_theme() {
  show_theme_info
  source "${themes[$current]}"
}

execute_theme

while true; do
  read -s -n 1 key
  if [[ $key == "q" ]]; then
    echo -e "\nTheme preview exited."
    exit 0
  elif [[ $key == $'\e' ]]; then
    read -s -n 2 rest
    if [[ $rest == "[C" ]]; then # Right arrow
      ((current++))
      [[ $current -ge $total ]] && current=0
      execute_theme
    elif [[ $rest == "[D" ]]; then # Left arrow
      ((current--))
      [[ $current -lt 0 ]] && current=$((total-1))
      execute_theme
    fi
  fi
done
