alias ssh='TERM=vt100 ssh'
#SVN 
export SVN_EDITOR=vim
export LC_ALL=C
#PATH changes
export PATH=/usr/local/mysql/bin:$PATH
export PATH=$PATH:$HOME/Library/Haskell/bin
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
export PATH=$PATH:$EC2_HOME/bin
export PATH=~/.ec2/bin:$PATH
export PATH=~/Dropbox/bin:$PATH
PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
export PATH
PATH="/opt/local/bin:$PATH"

export EC2_HOME=/Users/abhishekk/.ec2
export JAVA_HOME=/Library/Java/Home

PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
export PATH

PATH="/Users/abhishekk/bin:${PATH}"
export PATH

export PATH=/Users/abhishekk/.cabal/bin:$PATH 

#PKG_PATH
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig
export PATH="$PATH:/opt/maven/bin"

##MAVEN VARIABLES
export M2_HOME="/usr/share/maven"

#Alias settings for bash tools.
alias ll='ls -l'
alias sed='gsed'
alias wc='gwc'
alias grep='grep --color=tty'

#Personal Aliases

alias bld='growlnotify  -m" Build done, get back to work"'
alias komodo='open -a "Komodo Edit"'
alias wtc="curl -silent http://whatthecommit.com/ | grep '<p>'|sed s/'<p>'//"

##Svn aliases
alias sim='svn update --set-depth=immediates'
alias sin='svn update --set-depth=infinity'
alias surl="svn info | grep URL | cut -d' ' -f2"

##Maven aliases
alias mvn="/Users/abhishekk/bin/mvn-script.sh"
alias mvi="mvn clean install -DskipTests"
alias mi=" mvn idea:idea -DdownloadSources=true -DdownloadJavadocs=true"
alias me="mvn eclipse:clean eclipse:eclipse -DdownloadSources=true"

##Codereview 
alias codereview='/usr/bin/upload.py -s codereview.flipkart.com'
alias stag=' date "+nm%d%m%Y-%H%Mkona"'

dad()
{
## Returns to the nearest parent directory with pom.xml
	while [ ! -e "pom.xml"  ]
		do
			cd ..
				
		done
}


svndiff()
{
      svn diff "${@}" | view -
}


## Bash Directory Bookmarks
alias m1='alias g1="cd `pwd`"'
alias m2='alias g2="cd `pwd`"'
alias m3='alias g3="cd `pwd`"'
alias m4='alias g4="cd `pwd`"'
alias m5='alias g5="cd `pwd`"'
alias m6='alias g6="cd `pwd`"'
alias m7='alias g7="cd `pwd`"'
alias m8='alias g8="cd `pwd`"'
alias m9='alias g9="cd `pwd`"'
alias mdump='alias|grep -e "alias g[0-9]"|grep -v "alias m" > ~/.bookmarks'
alias lma='alias | grep -e "alias g[0-9]"|grep -v "alias m"|sed "s/alias //"'
touch ~/.bookmarks
source ~/.bookmarks

##BASH PROMPT COLOR SETTINGS
export CLICOLOR=1
export LSCOLORS=cxFxCxDxBxegedabagacad

function parse_git_branch {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

## Git thingys
GREEN='\e[1;32m'
RESET='\e[0m'
MAGENTA='\e[0;35m'
GREEN='\e[0;32m'
RED='\e[0;31m'
BLUE='\e[0;34m'
#export PS1="[$BLUE\T$RESET] $RED\h : \w $RESET git:$GREEN"'$(parse_git_branch)'"$RESET\n$RESET$ "
export PS1="[$BLUE\T$RESET] $RED\h : \w $RESET git:$GREEN"'$(parse_git_branch)'"$RESET\n$ "