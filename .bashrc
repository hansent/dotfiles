# If not running interactively, don't do anything
[ -z "$PS1" ] && return

export EDITOR=vim

export PATH=/usr/local/bin:~/.bin:$PATH
export $PYTHONPATH=~/code/kivy:$PYTHONPATH
export PYTHONDONTWRITEBYTECODE=1

TEHANSEN_DEFAULT_COLOR="[00m"
TEHANSEN_GRAY_COLOR="[37m"
TEHANSEN_PINK_COLOR="[35m"
TEHANSEN_GREEN_COLOR="[32m"
TEHANSEN_ORANGE_COLOR="[33m"
TEHANSEN_RED_COLOR="[31m"
if [ `id -u` == '0' ]; then
  TEHANSEN_USER_COLOR=$TEHANSEN_RED_COLOR
else
  TEHANSEN_USER_COLOR=$TEHANSEN_PINK_COLOR
fi

TEHANSEN_VC_PROMPT=$' on \033[34m%n\033[00m:\033[00m%[unknown]b\033[32m'
TEHANSEN_VC_PROMPT_EX="$TEHANSEN_VC_PROMPT%m%u"

tehansen_vcprompt() {
  path=`pwd`
  prompt="$TEHANSEN_VC_PROMPT_EX"a a
  vcprompt -f "$prompt"
}


tehansen_lastcommandfailed() {
  code=$?
  if [ $code != 0 ]; then
    echo -n $'\033[37m exited \033[31m'
    echo -n $code
    echo -n $'\033[37m'
  fi
}

tehansen_backgroundjobs() {
  jobs|python -c 'if 1:
    import sys
    items = ["\033[36m%s\033[37m" % x.split()[2]
             for x in sys.stdin.read().splitlines()]
    if items:
      if len(items) > 2:
        string = "%s, and %s" % (", ".join(items[:-1]), items[-1])
      else:
        string = ", ".join(items)
      print "\033[37m running %s" % string
  '
}

tehansen_virtualenv() {
  if [ x$VIRTUAL_ENV != x ]; then
    if [[ $VIRTUAL_ENV == *.virtualenvs/* ]]; then
      ENV_NAME=`basename "${VIRTUAL_ENV}"`
    else
      folder=`dirname "${VIRTUAL_ENV}"`
      ENV_NAME=`basename "$folder"`
    fi
    echo -n $' \033[37mworkon \033[31m'
    echo -n $ENV_NAME
    echo -n $'\033[00m'
  fi
}

export TEHANSEN_BASEPROMPT='\n\e${TEHANSEN_USER_COLOR}\u\
\e${TEHANSEN_GRAY_COLOR}@\e${TEHANSEN_ORANGE_COLOR}\h\
\e${TEHANSEN_GRAY_COLOR}:\e${TEHANSEN_GREEN_COLOR}\w\
`tehansen_lastcommandfailed`\
# \e${TEHANSEN_GRAY_COLOR}`tehansen_vcprompt`\
`tehansen_backgroundjobs`\
`tehansen_virtualenv`\
\e${TEHANSEN_DEFAULT_COLOR}'
export PS1="${TEHANSEN_BASEPROMPT}
$ "

export TERM=xterm-color
export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'
export CLICOLOR=1
alias ls='ls --color=auto'
export IGNOREEOF=1

# virtualenvwrapper and pip
if [ `id -u` != '0' ]; then
  export VIRTUALENV_USE_DISTRIBUTE=1
  if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
    export WORKON_HOME=$HOME/.virtualenvs
    source /usr/local/bin/virtualenvwrapper.sh
  fi
  #export PIP_VIRTUALENV_BASE=$WORKON_HOME
  #export PIP_RESPECT_VIRTUALENV=true
fi



#if [ x`which hub` != x ]; then
#  alias git=hub
#fi

if [ -f /usr/local/git/contrib/completion ]; then
  . /usr/local/git/contrib/completion/git-completion.bash
fi
if [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi

# don't let virtualenv show prompts by itself
VIRTUAL_ENV_DISABLE_PROMPT=1

