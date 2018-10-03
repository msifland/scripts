# The follow entry needs to be the first line of this file, it fixes this warning in terminal: ** (mate-session:26823): WARNING **: Couldn't register with accessibility bus: Did not receive a reply.
export NO_AT_BRIDGE=1
# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Make sure 256 color loads to terminal
export TERM=xterm-256color

# Set up random color variables for themes at bottom of this file
num1=$((RANDOM % 255+1))
num2=$((RANDOM % 255+1))
num3=$((RANDOM % 255+1))
rand_color="\033[38;5;$((RANDOM % 255+1))m"
restore='\033[0m'

########## Type in terminal to see colors: spectrum_ls ##########

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="msi"
#ZSH_THEME="random"

# Uncomment the following line to use case-sensitive completion.
 CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
 HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=7

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
 ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
 COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
 HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git adb archlinux asdf colorize common-aliases common-not-found compleat emoji frontend-search git-extras github git-prompt python rand-quote sudo systemd systemadmin textmate themes web-search)
#colored-man-pages



# User configuration

export PATH=$HOME/bin:/usr/local/bin:$PATH
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#

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

fucntion iso-gen(){
		/$HOME/scripts/gen-iso
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
export PATH="/usr/lib/jvm/default-java/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:$HOME/Android/Sdk:$HOME/Android/Sdk/platform-tools:$HOME/Android/Sdk/tools:$HOME/Android/Sdk/build-tools/:$HOME/Android/android-studio/bin:$PATH"
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

########## Personalized Theme with Random color generation #####
########## Type in terminal to see colors: spectrum_ls #########
# Grab the current date (%D) and time (%T) wrapped in {}: {%D %T}
MSI_CURRENT_TIME_="%{$fg[white]%}[%{$FG[$num3]%}%w,%t%{$fg[white]%}]%{$reset_color%}"
# Grab the current version of ruby in use (via RVM): [ruby-1.8.7]
if [ -e /.rvm/bin/rvm-prompt ]; then
  MSI_CURRENT_RUBY_="%{$fg[white]%}[%{$FG[$num2]%}\$(/.rvm/bin/rvm-prompt i v)%{$fg[white]%}]%{$reset_color%}"
else
  if which rbenv &> /dev/null; then
    MSI_CURRENT_RUBY_="%{$fg[white]%}[%{$FG[$num1]%}\$(rbenv version | sed -e 's/ (set.*$//')%{$fg[white]%}]%{$reset_color%}"
  fi
fi
# Grab the current machine name: muscato
MSI_CURRENT_MACH_="%{$FG[$num2]%}%m%{$fg[white]%}:%{$reset_color%}"
# Grab the current filepath, use shortcuts: ~/Desktop
# Append the current git branch, if in a git repository: ~aw@master
MSI_CURRENT_LOCA_="%{$FG[$num2]%}%~\$(git_prompt_info)%{$reset_color%}\$(parse_git_dirty)"
# Grab the current username: dallas
MSI_CURRENT_USER_="%{$FG[$num1]%}%n%{$reset_color%}"
# Use a % for normal users and a # for privelaged (root) users.
MSI_PROMPT_CHAR_="%{$fg[white]%}%(!.#.)%{$reset_color%}"
# For the git prompt, use a white @ and blue text for the branch name
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[white]%}@%{$FG[$num1]%}"
# Close it all off by resetting the color and styles.
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
# Do nothing if the branch is clean (no changes).
ZSH_THEME_GIT_PROMPT_CLEAN=""
# Add 3 cyan ✗s if this branch is diiirrrty! Dirty branch!
ZSH_THEME_GIT_PROMPT_DIRTY="%{$FG[$num1]%}✗✗✗"

# Put it all together! (The 'ENTER's' actually create a 'NEWLINE' on prompt
PROMPT="
$MSI_CURRENT_TIME_$MSI_CURRENT_RUBY_$MSI_CURRENT_MACH_$MSI_CURRENT_USER_$MSI_PROMPT_CHAR_ $MSI_CURRENT_LOCA_
%{$FG[$num2]%} └──╼>> "

############### End of personalized theme ###########################

############### Customization for commands as typing ################
# Declare the variable
typeset -A ZSH_HIGHLIGHT_STYLES
# To differentiate aliases from other command types
ZSH_HIGHLIGHT_STYLES[command]="fg=$num1,bold"
ZSH_HIGHLIGHT_STYLES[alias]="fg=$num2"
ZSH_HIGHLIGHT_STYLES[function]="fg=$num1"
ZSH_HIGHLIGHT_STYLES[path]="fg=underline"
ZSH_HIGHLIGHT_STYLES[default]="fg=$num2"
############### End typing customization ############################

plugins+=(zsh-completions)
autoload -U compinit && compinit

# This has to be at the end of the file to work properly
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

echo
echo
