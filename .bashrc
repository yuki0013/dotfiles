alias ..='cd ../'
alias la='ls -lAhFG --color=auto'
alias grep='grep --color=auto'
alias ll='ls -lhFG --color=auto'

export PROMPT_COMMAND="history -a"
export PATH="~/bin:$PATH"

PS1="[\t] \[\e[32m\e[40m\]\u\[\e[0m\]@\[\e[36m\e[40m\]\h:\w\n\\[\e[0m\] $ "
