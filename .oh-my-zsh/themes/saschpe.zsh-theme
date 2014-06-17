local ret_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ %s)"
if [ $UID -eq 0 ] ; then
    local uid_color="%{$fg[red]%}"
else
    local uid_color="%{$fg[green]%}"
fi
PROMPT='${uid_color}%n%{$fg[cyan]%}@%m%{$reset_color%}:%{$fg[magenta]%}%3~%{$reset_color%} '
RPROMPT='$(git_prompt_info)$(hg_prompt_info)$(svn_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX=" git:%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

ZSH_THEME_HG_PROMPT_PREFIX=" hg:%{$fg[red]%}"
ZSH_THEME_HG_PROMPT_DIRTY="%{$fg[yellow]%}✗%{$reset_color%}"
ZSH_THEME_HG_PROMPT_CLEAN=""
ZSH_THEME_HG_PROMPT_SUFFIX="%{$reset_color%}"

ZSH_THEME_SVN_PROMPT_PREFIX=" svn:%{$fg[red]%}"
ZSH_THEME_SVN_PROMPT_DIRTY="%{$fg[yellow]%}✗%{$reset_color%}"
ZSH_THEME_SVN_PROMPT_CLEAN=""
ZSH_THEME_SVN_PROMPT_SUFFIX="%{$reset_color%}"
