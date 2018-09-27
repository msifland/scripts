#
# ~/.bashrc
#
# The follow entry needs to be the first line of this file, it fixes this warning in terminal: ** (mate-session:26823): WARNING **: Couldn't register with accessibility bus: Did not receive a reply.
export NO_AT_BRIDGE=1
export TERM=xterm-256color
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Set up random color variables for themes at bottom of this file
num1=$((RANDOM % 255+1))
num2=$((RANDOM % 255+1))
num3=$((RANDOM % 255+1))
rand_color="\033[38;5;$((RANDOM % 255+1))m"
restore='\033[0m'

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

#####Stuff from Xubuntu bash######
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
#case "$TERM" in
 #   xterm-color) color_prompt=yes;;
#esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt


# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

########################### My-Stuff ###############################

function up(){ ##>Navigates up number of directories.
LIMIT=$1
P=$PWD
for ((i=1; i <= LIMIT; i++))
do
    P=$P/..
done
cd $P
export MPWD=$P
}

function find-stuff(){ ##>Find items in a specified date rage for specified. directory
	sleep 1
	read -p "What directory would you like to find in?[/path/to/dir] " directory
	sleep 1
	if [[ -d "$directory" ]]; then
		read -p "What date range? Start date?[yyyy-mm-dd] " start_date
		sleep 1
		read -p "End date?[yyyy-mm-dd] " end_date
		sleep 1
		find "$directory" -type f -name "*" -newermt "$start_date" ! -newermt "$end_date"
	else
		echo "Not a valid directory, please try again..."
		find_stuff
	fi
}

function rom-sync(){ ##>Sync specified ROM.
	if [[ ! -z $1 ]]; then
		ROM="$1"
		$HOME/rom_scripts/sync-rom $ROM
	else
		echo "Usage: rom-sync bliss(ROM folder name)"
		echo
	fi
}

function rom-build(){ ##>Build specified ROM.
	if [[ ! -z $1 ]] && [[ ! -z $2 ]]; then
		clear
		cd
		ROM="$1"
		VAR="$2"
		$HOME/rom_scripts/build-rom $ROM $VAR
		sleep 1
		while true; do echo "n"; done | pkill java
	else
		cd
		echo "Usage: rom-build aicp marlin(ROM and Device name)"
		echo
	fi
}

function rom-clean(){ ##>Clean entire $OUT directory of specified ROM.
	if [[ ! -z $1 ]]; then
		ROM="$1"
		$HOME/rom_scripts/make_clean $ROM
	else
		echo "Usage: rom-clean bliss(ROM folder name), completely removes out directory."
		echo
	fi
}

function gapps-build(){ ##>Build gapps.
	$HOME/rom_scripts/build_gapps
}

function light-sensor-on(){ ##>Turn on computer ligh sensor for display brightness.
	echo "spike" | sudo -S sudo su -c "echo 1 > /sys/devices/platform/hp-wmi/als"
}

function light-sensor-off(){ ##>Turn off computer ligh sensor for display. brightness
	echo "spike" | sudo -S sudo su -c "echo 0 > /sys/devices/platform/hp-wmi/als"
}

function define(){ ##>Show the definition of a word.
	if [[ ! -z $1 ]]; then
		word="$1"
		curl dict://dict.org/d:"$word"
	else
		echo "Usage: define garrelous, gives all definitions of word."
		echo
	fi
}

function ran-num(){ ##>Generate a random number from a range of specified numbers.
echo -n "From how many numbers would like like to generate? "
read num
echo $((RANDOM % $num+1))
}

function sort-words(){ ##>Sort words alphabetically on screen or to a file.
	$HOME/scripts/unused/sort_words
}

function math(){ ##>Allow normal math functions.
if [[ ! -z $1 ]]; then
	math=$(echo "scale=7; (("$1"))" | bc)
	echo $math
else
	echo Usage: "math '5*6'" or "math '(5*4)/2'"
	echo
fi
}

function show-time(){ ##>Convert seconds into days, hours, minutes, seconds.
	if [[ ! -z $1 ]]; then
		$HOME/scripts/unused/show_time $1
	else
		echo "Usage: show-time 3987564(seconds), calculates into days, hours, minutes, seconds."
		echo
	fi
}

function edit-my-backup(){ ##>Edit folders to include and exclude for my_backup.
	nano $HOME/scripts/my-backup
}

function edit-virus-clamscan(){ ##>Edit folders to include and exclude for virus scans.
	nano $HOME/scripts/virus-clamscan
}

function oh-my-zsh-updater(){ ##>Updates oh-my-zsh.
	echo "Date & Time: $(date +"%m-%d-%y -- %r")\n" | tee /home/msifland/scripts/oh-my-zsh-update-log.txt
	upgrade_oh_my_zsh | tee -a /home/msifland/scripts/oh-my-zsh-update-log.txt
}

function file-open(){ ##>Opens a file by full name in current directory, or opens a file from full directory path, or open a directory by name and shows a list of files in that directory.
	if [[ -f "$1" ]]; then
		$HOME/scripts/open-file "$1"
	elif [[ -d "$1" ]]; then
		echo
		$HOME/scripts/open-file "$1"
		echo
	elif [[ -z "$1" ]]; then
		echo
		$HOME/scripts/open-file
		echo
	else
		echo
		echo "File does not exist in current directory. Try again."
		echo
	fi
}

function my-locate(){ ##>Finds files and folders by name in current dir recursively.
	if [[ ! -z $1 ]]; then
		$HOME/scripts/locate-file-names $1
	else
		echo 'Navigate to directory you want to search in recursively first.'
		echo 'Usage:  locate "gpg"
	locate "*pxe*"
	Use with the quotes. For best results use asterisk(*) on each side of word'
	fi
}

function delete-files(){ ##>Finds files and folders by name in current dir recursively, and delete.
	if [[ ! -z $1 ]]; then
		$HOME/scripts/delete_files $1
	else
		echo 'Navigate to directory you want to search in recursively first.'
		echo 'Usage:  delete-files "gpg"
	delete-files "*pxe*"
	Use with the quotes. For best results use asterisk(*) on each side of word'
	fi
}

function pid(){ ##>Search for pid by name.
	if [[ ! -z $1 ]]; then
		ps aux | grep -v grep | grep -i -e VSZ -e $1
	else
		echo 'Searches for processes by name.
	Usage:  pid python
		pid google
		pid chrome'
	fi
}

function conky-update(){ ##>Upates conky widget for network display
	$HOME/scripts/conky_iface_var.sh
}

function transfer(){ ##>Uploades files to https://transfer.sh
	if [[ ! -z $1 ]]; then
		FILE="$1"
		$HOME/scripts/transfer-sh $FILE
	else
		echo 'Usage:  transfer $HOME/scripts/updater
	transfer build
	transfer rom_scripts/build'
	fi
}

function goto-instructions(){ ##> Show how to use goto in scripts.
	echo '
	# Copy this text to your script
	#########################
	function goto(){
		label=$1
		cmd=$(sed -n "/$label:/{:a;n;p;ba};" $0 | grep -v ':$')
		eval "$cmd"
		exit
	}

	start=${1:-"start"}
	#########################

	goto start

	start:
	# your script goes here. . .
	'
}

######################################################################
###### Do not put any functions below here. Put them above here ######

function my-functions(){
	$HOME/scripts/my_functions
}
  #################################################################

### In line color options to be placed right before text to change color ###
# Example: echo "${ILCOLOR1}Hey, what up? ${ILCOLOR2}Nothing much. ${ILCOLOR3} Hey what about me??? ${ILRESTORE}Ok, see ya."
ILRAND1="\033[1;38;5;$((RANDOM % 255+1))m"
ILCOLOR1=`echo -e "${ILRAND1}"`
ILRAND2="\033[1;38;5;$((RANDOM % 255+1))m"
ILCOLOR2=`echo -e "${ILRAND2}"`
ILRAND3="\033[1;38;5;$((RANDOM % 255+1))m"
ILCOLOR3=`echo -e "${ILRAND3}"`
ILRAND4="\033[1;38;5;$((RANDOM % 255+1))m"
ILCOLOR4=`echo -e "${ILRAND4}"`
ILREST='\033[0m'
ILRESTORE=`echo -e "${ILREST}"`

export ILCOLOR1=$ILCOLOR1
export ILCOLOR2=$ILCOLOR2
export ILCOLOR3=$ILCOLOR3
export ILCOLOR4=$ILCOLOR4
export ILRESTORE=$ILRESTORE

##################Peronal Greeting######################
# Color ranmdom number variables are calculated at the top of file -c$num1,$num2
echo
screenfetch -A 'Linux' | pv -qL 2000
echo
echo -e ${rand_color} "=========================================================================================="
echo "     Welcome to your $(uname -rmno) machine, Michael"
echo "     Kernel Version: $(uname -v)"
echo -e "     Uptime: $(uptime)"
echo "     Disk use:  Prtitn          Total Used  Rmn   %Us MntPnt"
df -h | grep /dev/sd | while read line; do echo -e "\t\t$line"; done
echo "     External IP: $(curl -s checkip.dyndns.org | sed -e 's/.*Current IP Address: //' -e 's/<.*$//') / Internal IP: $(ip address | grep "inet 19" | sed '/vmnet/ d' | gawk '{print $2}' | sed 's:/24::g')"
echo " =========================================================================================="
echo -e ${restore}
echo

#############Aliases###########################
alias cd..="cd .." #Moves up 1 directory
alias errors="systemctl --failed --all && journalctl -p 3 -xb" #Show system errors
alias perms='stat -c "%a %n" *' #Get permissions in numeric form
alias python="python2"
alias gmt="$HOME/maps/gmt/gmt"
alias rec-key="sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys"
#alias apt-i="sudo apt install"
#alias apt-r="sudo apt purge"
#alias apt-s="apt search"
#alias apti-s="aptitude search"
alias del-key="sudo apt-key del"
alias apt-list="apt list --installed"
alias apt-list-s="apt list --installed | grep "$1""
alias nethogs="sudo nethogs -p"
#alias android="$HOME/Android/Sdk/tools/bin/sdkmanager"

#############Android stuff#####################
export PATH="$HOME/rom_scripts:$PATH"
export PATH="$HOME/scripts:$PATH"
export PATH="$HOME/scripts/kernel_scripts:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="/usr/local/bin:$PATH"
export ANDROID_HOME="$HOME/Android/Sdk:$ANDROID_HOME"
export PATH="/usr/lib/jvm/default-java/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:$HOME/Android/Sdk:$HOME/Android/Sdk/platform-tools:$HOME/Android/Sdk/tools:$HOME/Android/Sdk/build-tools/:$PATH"
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin:$PATH"
# This line specifically call the latest build tools number folder(mainly for building opengapps). It also deletes any older folders.
export PATH="$(find $HOME/Android/Sdk/build-tools/ -mindepth 1 -maxdepth 1 -type d):$PATH"

BLD_TOOLS_KEEP=$(ls -t $HOME/Android/Sdk/build-tools/ | head -n 1)
find $HOME/Android/Sdk/build-tools/ -mindepth 1 -maxdepth 1 ! -name "$BLD_TOOLS_KEEP" -execdir rm -rf 2>/dev/null {} \+
#find . -maxdepth 1 ! -name "$BLD_TOOLS_KEEP" -print0 | xargs -0 rm -rf 2>/dev/null

export PATH="./prebuilts/sdk/tools:$PATH"
export JAVA_HOME=/usr/lib/jvm/default-java
export EDITOR="nano"
export DIPLAY=:0
export USE_SDK_WRAPPER=true

#This has to go after all $PATH variables.
alias sudo="sudo env PATH=$PATH"
###############################################

################ Terminal Jokes ###############
if [ "$PS1" ]; then
    wget "http://api.icndb.com/jokes/random" -qO- | jshon -e value -e joke -u
echo
fi

######################### End of My-Stuff ##########################
