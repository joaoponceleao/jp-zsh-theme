# ------------------------------------------------------------------------------
#          FILE:  jp.zsh-theme
#   DESCRIPTION:  oh-my-zsh theme file.
#        AUTHOR:  Joao Ponce Leao (sorin.ionescu@gmail.com)
#        NOTES:   Originally base o Sorin Ionescu's sorin oh-my-zsh theme.
#                 Vi-prompt requires plugins/vi-mode.
#                 Battery prompt requires plugins/battery/
#                 Python prompt requires zsh-python-prompt
#                 (https://github.com/joaoponceleao/zsh-python-prompt)
# ------------------------------------------------------------------------------

funtion vi_prompt(){
    if {echo $fpath | grep -q "plugins/vi-mode"}; then
        VI_INS_MODE="%{$fg_bold[green]%} [% Insert]% %{$reset_color%}"
        VI_CMD_MODE="%{$fg_bold[yellow]%} [% Command]% %{$reset_color%}"
        echo "${${KEYMAP/vicmd/${VI_CMD_MODE}}/(main|viins)/${VI_INS_MODE}}"
    else
        echo ""
    fi
}

function batt_prompt(){
  if {echo $fpath | grep -q "plugins/battery"}; then
    echo "$(battery_pct_prompt)"
  else
    echo ""
  fi
}

function node_prompt(){
    echo "node@$(node -v)"
}

if [[ "$TERM" != "dumb" ]] && [[ "$DISABLE_LS_COLORS" != "true" ]]; then
  MODE_INDICATOR="%{$fg_bold[red]%}❮%{$reset_color%}%{$fg[red]%}❮❮%{$reset_color%}"
  local return_status="%{$fg[red]%}%(?..⏎)%{$reset_color%}"
  
  PROMPT='%{$fg[cyan]%}%c$(git_prompt_info) %(!.%{$fg_bold[red]%}#.%{$fg_bold[green]%}❯)%{$reset_color%} '
  
  ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[blue]%}git%{$reset_color%}:%{$fg[red]%}"
  ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
  ZSH_THEME_GIT_PROMPT_DIRTY=""
  ZSH_THEME_GIT_PROMPT_CLEAN=""

  RPROMPT='${return_status}$(git_prompt_status)%{$reset_color%} $(batt_prompt) %{$fg_bold[blue]%}$ZSH_PYTHON_PROMPT $(node_prompt) $(vi_prompt)%($reset_color%}'

  ZSH_THEME_GIT_PROMPT_ADDED="%{$fg_bold[green]%} ●"
  ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg_bold[blue]%} ●"
  ZSH_THEME_GIT_PROMPT_DELETED="%{$fg_bold[red]%} ●"
  ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg_bold[red]%} !"
  ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg_bold[yellow]%} ●"
else 
  MODE_INDICATOR="❮❮❮"
  local return_status="%(?::⏎)"
  
  PROMPT='%c$(git_prompt_info) %(!.#.❯) '

  ZSH_THEME_GIT_PROMPT_PREFIX=" git:"
  ZSH_THEME_GIT_PROMPT_SUFFIX=""
  ZSH_THEME_GIT_PROMPT_DIRTY=""
  ZSH_THEME_GIT_PROMPT_CLEAN=""

  RPROMPT='${return_status}$(git_prompt_status) $(batt_prompt) ZSH_PYTHON_PROMPT $(node_prompt) $(vi_prompt)'

  ZSH_THEME_GIT_PROMPT_ADDED=" +"
  ZSH_THEME_GIT_PROMPT_MODIFIED=" >"
  ZSH_THEME_GIT_PROMPT_DELETED=" -"
  ZSH_THEME_GIT_PROMPT_UNMERGED=" !"
  ZSH_THEME_GIT_PROMPT_UNTRACKED=" ?"
fi
