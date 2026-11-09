export PATH="/opt/homebrew/bin:$PATH"
export VAULT_ADDR="https://vault.adjust.com"
source ~/.ssh/ssh_helper.sh

# Alias for ics_combine command
alias gen_cal="~/SYNCTHING_FOLDER/binaries/ics_combine ~/SYNCTHING_FOLDER/calendar/"

# OpenCode host client connected to the Docker deployment.
export PATH="/Users/alko/src/opencode/opencode_in_docker/bin:$PATH"

# Select the current (or supplied) directory as the Docker OpenCode workspace.
alias oc='/Users/alko/src/opencode/opencode_in_docker/scripts/oc.sh'

alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles_config/ --work-tree=$HOME'

# Personal shell preferences
export EDITOR="nvim"
# Ctrl-D normally sends EOF at an empty prompt.  IGNORE_EOF only delays that
# exit after repeated presses, so make Ctrl-D a no-op in the line editor.
setopt IGNORE_EOF
zle -N ignore-eof
ignore-eof() {}
bindkey '^D' ignore-eof
export PATH="$HOME/.tmux/plugins/tmuxifier/bin:$PATH"

if command -v tmuxifier >/dev/null 2>&1; then
  eval "$(tmuxifier init -)"

  tmuxifier_smart_load() {
    local session_name="$1"
    if [ -z "$TMUX" ]; then
      tmuxifier load-session "${session_name}"
    else
      echo "Do not create new Tmuxifier sessions inside Tmux."
    fi
  }

  alias tm='tmuxifier load-session '
fi

alias gl='git log --oneline --graph'
alias n='nvim "$(fzf)"'
export FZF_DEFAULT_OPTS="--height=70% --layout=reverse --info=inline --border --margin=1 --padding=1"

# Optional machine-specific settings.
[ -f ~/.zshrc.private.personal ] && source ~/.zshrc.private.personal
[ -f ~/.zshrc.private.work ] && source ~/.zshrc.private.work

echo "\n"
echo "nf - notes_find - find a token in notes"
echo "\n"

nf() {
  local TAG="$1"
  local case_flag=(-i)

  [[ "$2" == "-s" ]] && case_flag=()

  find . -type f -not -path '*/.*' -print0 |
    while IFS= read -r -d '' f; do
      [[ "${f:l}" == *"${TAG:l}"* ]] && [[ "$2" != "-s" ]] ||
        rg -IqF "${case_flag[@]}" -- "$TAG" "$f" && echo "$f"
    done
}
