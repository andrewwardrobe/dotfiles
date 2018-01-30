# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

export FGCYAN="\[\033[36m\]"
export FGNORMAL="\[\033[0m\]"
export FGRED="\[\033[31m\]"
export FGPURPLE="\[\033[35m\]"
export FGBLUE="\[\033[34m\]"
export FGGREEN="\[\033[32m\]"
export FGYELLOW="\[\033[1;33m\]"
export FGPINK="\[\033[1;35m\]"
export FGBROWN="\[\033[33m\]"
export FGWHITE="\[\033[1;37m\]"
export FGLBLUE="\[\033[1;34m\]"
export FGLGREEN="\[\033[1;32m\]"


# User specific aliases and functions
function short {
 if [[ $(echo $1 | wc -c) -lt 30 ]]
 then
   echo $1
 else
   if [[ $(echo $1 | grep -o "/" | wc -l  ) -lt 3 ]]; then
     echo $1
   else
     echo ".../$(echo $1 | awk -F\/ '{print $(NF-2),$(NF-1),$(NF)}' | sed 's# #\/#g')"
   fi
 fi
}

function get_dir(){
  export DIR=$(pwd)

  GBRANCH=" ($(git symbolic-ref --short -q HEAD 2>/dev/null))"
  if [ $? -ne 0 ]; then
    GBRANCH=""
  fi
  if [ "${DIR}" == "${HOME}" ]
  then
    DIR="~"
  else
          if [[ "${DIR}" == *"${HOME}"* ]]; then
            DIR=$(echo $DIR | sed "s#${HOME}#~##")
          else
            DIR=$(short ${DIR})
          fi
  fi
  echo "${DIR}${GBRANCH}"
}


function exit_status(){
  ret=$?
  if [[ $ret -eq 0 ]]; then
    PMT="${FGGREEN}\$${FGNORMAL}"
  else
    PMT="${FGRED}\$${FGNORMAL}"
  fi
  export PS1="[${FGGREEN}\u@$(hostname --short)${FGNORMAL}]:[${FGYELLOW}\W${FGNORMAL}] ${FGCYAN}$(date +%T:)${FGNORMAL} ${PMT} " 
}

function docker_clean(){
docker ps -a -q | xargs -r docker stop
docker ps -a -q | xargs -r docker rm
docker volume ls -q  | xargs -r docker volume rm
docker images -q  | xargs -r docker rmi -f
}


export PROMPT_COMMAND="exit_status"
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk
alias vi=vim
export PATH=$PATH:/opt/gradle-3.5/bin

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/awar/.sdkman"
[[ -s "/home/awar/.sdkman/bin/sdkman-init.sh" ]] && source "/home/awar/.sdkman/bin/sdkman-init.sh"
alias config='/usr/bin/git --git-dir=/home/awar/.cfg/ --work-tree=/home/awar'
