alias ..='cd ../'
alias ls='ls --color=auto'
alias la='ls -lAhFG --color=auto'
alias grep='grep --color=auto'
alias ll='ls -lhFG --color=auto'

export PROMPT_COMMAND="history -a"
export PATH="~/bin:$PATH"

PS1="[\t] \[\e[32m\]\u\[\e[m\]@\[\e[36m\]\h:\w\n\\[\e[m\] $ "
