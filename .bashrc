[ -z "$PS1" ] && return

export EDITOR=gvim
export PATH=${HOME}/.bin:/usr/local/bin:$PATH
export PYTHONDONTWRITEBYTECODE=1
export PYTHONPATH=${HOME}/code/kivy:${PYTHONPATH}

alias k='kill -9 `jobs -p` 2>/dev/null && sleep 0.1 && jobs'
alias ls='ls -Ah'

source ${HOME}/.aws/auth &> /dev/null
source /usr/local/git/contrib/completion/git-completion.bash &> /dev/null
source /etc/bash_completion &> /dev/null
source /usr/local/bin/virtualenvwrapper.sh &> /dev/null

# VIRTUALENVWRAPPER
#==============================================================================
export PROJECT_HOME="~/code"
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENV_USE_DISTRIBUTE=1
export VIRTUAL_ENV_DISABLE_PROMPT=1
function mkvirtenv {
    proj=$1
    mkvirtualenv -a ${HOME}/code/${proj} --distribute ${proj}
}



# PROMPT COLORS / FORMAT
#==============================================================================
export TERM=xterm-color
export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'
export CLICOLOR=1
export IGNOREEOF=1
export PS1='\n\e${TEHANSEN_GREEN_COLOR}\w\
`tehansen_lastcommandfailed` \
\e${TEHANSEN_GRAY_COLOR}`tehansen_vcprompt`\
`tehansen_backgroundjobs`\
`tehansen_virtualenv`\
\e${TEHANSEN_DEFAULT_COLOR}
$ '

TEHANSEN_DEFAULT_COLOR="[00m"
TEHANSEN_GRAY_COLOR="[37m"
TEHANSEN_PINK_COLOR="[35m"
TEHANSEN_GREEN_COLOR="[32m"
TEHANSEN_ORANGE_COLOR="[33m"
TEHANSEN_RED_COLOR="[31m"
TEHANSEN_USER_COLOR=$TEHANSEN_PINK_COLOR
if [ `id -u` == '0' ]; then
  TEHANSEN_USER_COLOR=$TEHANSEN_RED_COLOR
fi
TEHANSEN_VC_PROMPT=$' \033[33m%n\033[00m:\033[00m%[unknown]b\033[32m'
TEHANSEN_VC_PROMPT_EX="$TEHANSEN_VC_PROMPT%m%u"

tehansen_vcprompt() {
  path=`pwd`
  prompt="$TEHANSEN_VC_PROMPT_EX"
  vcprompt -f "$prompt"
}

tehansen_lastcommandfailed() {
  code=$?
  if [ $code != 0 ]; then
    echo -n $'\033[37m EC \033[31m'
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



