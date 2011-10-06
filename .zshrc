# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"


# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git pip brew autojump vi-mode )
bindkey -M vicmd '?' history-incremental-search-backward
source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=/Users/abhishekk/.cabal/bin:/Users/abhishekk/bin:/Library/Frameworks/Python.framework/Versions/2.7/bin:/opt/local/bin:/Library/Frameworks/Python.framework/Versions/2.7/bin:/Users/abhishekk/Dropbox/bin:/Users/abhishekk/.ec2/bin:/opt/local/bin:/opt/local/sbin:/usr/local/mysql/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/git/bin:/usr/X11/bin:/opt/local/bin:/Users/abhishekk/Library/Haskell/bin:/bin

#PKG_PATH
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig

#Alias settings for bash tools.
alias ll='ls -l'
alias sed='gsed'
alias wc='gwc'
alias readlink='greadlink'
alias grep='grep --color=tty'

#Personal Aliases

alias bld='growlnotify  -m" Build done, get back to work"'
alias wtc="curl -silent http://whatthecommit.com/ | grep '<p>'|sed s/'<p>'//"

##Svn aliases
alias sim='svn update --set-depth=immediates'
alias sin='svn update --set-depth=infinity'
alias surl="svn info | grep URL | cut -d' ' -f2"

##Maven aliases
alias mvn="/Users/abhishekk/bin/mvn-script.sh"
alias mvi="mvn clean install -DskipTests --quiet"
alias mi=" mvn idea:idea -DdownloadSources=true -DdownloadJavadocs=true"
alias me="mvn eclipse:clean eclipse:eclipse -DdownloadSources=true"

##Codereview 
alias codereview='~/bin/upload.py -s codereview.flipkart.com'
alias stag=' date "+nm%d%m%Y-%H%Mkona"'

alias home='ssh pf-fq2.nm.flipkart.com'
alias mongo='mongod --dbpath ~/tmp/mongodata'
export JAVA_HOME=$(/usr/libexec/java_home) 


export SVN_EDITOR="vim"


function dad () {
    cd ..
    while [[ ! -e "pom.xml" && ! -e "build.sbt" ]]; do 
        cd ..
    done
}
