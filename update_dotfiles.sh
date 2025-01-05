#!/bin/bash

cp \
	~/.config/ghostty/config \
	~/.hushlogin \
	~/.config/fastfetch/config.jsonc \
	~/.config/nvim/init.lua \
	~/.config/nvim/lua/custom/plugins/init.lua \
	~/.config/nvim/lua/custom/plugins/lualine.lua \
	~/.config/nvim/lua/custom/plugins/render-markdown.lua \
	~/.config/starship.toml \
	~/.config/wezterm/wezterm.lua \
	./

echo "Files copied."

if [[ -n $(git ls-files --others --exclude-standard) || \
      -n $(git diff --name-only) || \
      -n $(git diff --cached --name-only) || \
      -n $(git ls-files --unmerged) ]]; then
    echo "Changes found."
    if [ -z "$1" ]; then
        echo "Error: Commit message required."
        exit 1
    fi
    git add .
    git commit -m "$1"
    git push origin main
    echo "Changes pushed to git repo, with message: $1."
else
    echo "All files up to date."
fi
