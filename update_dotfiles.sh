#!/bin/bash

RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
BLUE="\033[34m"
BOLD="\033[1m"
RESET="\033[0m"  # Reset all attributes

# copy all dotfiles to destination
cp ~/.config/ghostty/config ./ghostty/config
cp ~/.config/fastfetch/config.jsonc ./fastfetch/config.jsonc
cp ~/.config/nvim/init.lua ./nvim/init.lua
cp ~/.config/nvim/lua/custom/plugins/init.lua ./nvim/plugins/init.lua
cp ~/.config/nvim/lua/custom/plugins/lualine.lua ./nvim/plugins/lualine.lua
cp ~/.config/nvim/lua/custom/plugins/render-markdown.lua ./nvim/plugins/render-markdown.lua
cp ~/.hushlogin ./.hushlogin
cp ~/.config/starship.toml ./starship.toml
cp ~/.config/wezterm/wezterm.lua ./wezterm/wezterm.lua

echo -e "${BOLD}${GREEN}Files copied.${RESET}"

# check if files changed since last merge
if [[ -n $(git ls-files --others --exclude-standard) || \
      -n $(git diff --name-only) || \
      -n $(git diff --cached --name-only) || \
      -n $(git ls-files --unmerged) ]]; then
    echo -e "${BOLD}${BLUE}Changes found.${RESET}"
    # check if commit message provided before committing
    if [ -z "$1" ]; then
        echo -e "${BOLD}${RED}Error: Commit message required.${RESET}"
        exit 1
    fi
    git add .
    git commit -m "$1"
    git push origin main
    echo -e "${BOLD}${GREEN}Changes pushed to git repo, with message: $1.${RESET}"
else
    echo -e "${BOLD}${BLUE}All files up to date.${RESET}"
fi
