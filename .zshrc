
## Options {{{
setopt correct                                                  # Auto correct mistakes
setopt extendedglob                                             # Extended globbing. Allows using regular expressions with *
setopt nocaseglob                                               # Case insensitive globbing
setopt rcexpandparam                                            # Array expension with parameters
setopt nocheckjobs                                              # Don't warn about running processes when exiting
setopt numericglobsort                                          # Sort filenames numerically when it makes sense
setopt nobeep                                                   # No beep
setopt appendhistory                                            # Immediately append history instead of overwriting
setopt histignorealldups                                        # If a new command is a duplicate, remove the older one
setopt autocd                                                   # if only directory path is entered, cd there.
setopt inc_append_history                                       # save commands are added to the history immediately, otherwise only when shell exits.

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'       # Case insensitive tab completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"         # Colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' rehash true                              # automatically find new executables in path 
# Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.config/zsh/cache
HISTFILE=~/.config/zhistory
HISTSIZE=10000
SAVEHIST=10000
WORDCHARS=${WORDCHARS//\/[&.;]}                                 # Don't consider certain characters part of the word
# }}}

## Keybindings {{{
bindkey -e
bindkey '^[[7~' beginning-of-line                               # Home key
bindkey '^[[H' beginning-of-line                                # Home key
if [[ "${terminfo[khome]}" != "" ]]; then
  bindkey "${terminfo[khome]}" beginning-of-line                # [Home] - Go to beginning of line
fi
bindkey '^[[8~' end-of-line                                     # End key
bindkey '^[[F' end-of-line                                     # End key
if [[ "${terminfo[kend]}" != "" ]]; then
  bindkey "${terminfo[kend]}" end-of-line                       # [End] - Go to end of line
fi
bindkey '^[[2~' overwrite-mode                                  # Insert key
bindkey '^[[3~' delete-char                                     # Delete key
bindkey '^[[C'  forward-char                                    # Right key
bindkey '^[[D'  backward-char                                   # Left key
bindkey '^[[5~' history-beginning-search-backward               # Page up key
bindkey '^[[6~' history-beginning-search-forward                # Page down key

# Navigate words with ctrl+arrow keys
bindkey '^[Oc' forward-word                                     #
bindkey '^[Od' backward-word                                    #
bindkey '^[[1;5D' backward-word                                 #
bindkey '^[[1;5C' forward-word                                  #
bindkey '^H' backward-kill-word                                 # delete previous word with ctrl+backspace
bindkey '^[[Z' undo                                             # Shift+tab undo last action
# }}}

## Aliases {{{
alias cp="cp -i"                                                # Confirm before overwriting something
alias df='df -h'                                                # Human-readable sizes
alias free='free -m'                                            # Show sizes in MB
# }}}

# Theming {{{
autoload -U compinit colors zcalc
compinit -d
colors

# Color man pages
export LESS_TERMCAP_mb=$'\E[01;32m'
export LESS_TERMCAP_md=$'\E[01;32m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;47;34m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;36m'
export LESS=-R
# }}}

## Plugins {{{
# Enable fish style features
# Use syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# Use history substring search
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
# bind UP and DOWN arrow keys to history substring search
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey '^[[A' history-substring-search-up			
bindkey '^[[B' history-substring-search-down

# Offer to install missing package if command is not found
if [[ -r /usr/share/zsh/functions/command-not-found.zsh ]]; then
    source /usr/share/zsh/functions/command-not-found.zsh
    export PKGFILE_PROMPT_INSTALL_MISSING=1
fi
# }}}

## Set terminal title {{{
# Set terminal window and tab/icon title
#
# usage: title short_tab_title [long_window_title]
#
# See: http://www.faqs.org/docs/Linux-mini/Xterm-Title.html#ss3.1
# Fully supports screen and probably most modern xterm and rxvt
# (In screen, only short_tab_title is used)
function title {
  emulate -L zsh
  setopt prompt_subst

  [[ "$EMACS" == *term* ]] && return

  # if $2 is unset use $1 as default
  # if it is set and empty, leave it as is
  : ${2=$1}

  case "$TERM" in
    xterm*|putty*|rxvt*|konsole*|ansi|mlterm*|alacritty|st*)
      print -Pn "\e]2;${2:q}\a" # set window name
      print -Pn "\e]1;${1:q}\a" # set tab name
      ;;
    screen*|tmux*)
      print -Pn "\ek${1:q}\e\\" # set screen hardstatus
      ;;
    *)
    # Try to use terminfo to set the title
    # If the feature is available set title
    if [[ -n "$terminfo[fsl]" ]] && [[ -n "$terminfo[tsl]" ]]; then
      echoti tsl
      print -Pn "$1"
      echoti fsl
    fi
      ;;
  esac
}

ZSH_THEME_TERM_TAB_TITLE_IDLE="%15<..<%~%<<" #15 char left truncated PWD
ZSH_THEME_TERM_TITLE_IDLE="%n@%m:%~"
# }}}

## Pre & Post exec {{{
# Runs before showing the prompt
function mzc_termsupport_precmd {
  return
  # Uncomment below if you want this for some reason
  #[[ "${DISABLE_AUTO_TITLE:-}" == true ]] && return
  #title $ZSH_THEME_TERM_TAB_TITLE_IDLE $ZSH_THEME_TERM_TITLE_IDLE
}

# Runs before executing the command
function mzc_termsupport_preexec {
  [[ "${DISABLE_AUTO_TITLE:-}" == true ]] && return

  emulate -L zsh

  # split command into array of arguments
  local -a cmdargs
  cmdargs=("${(z)2}")
  # if running fg, extract the command from the job description
  if [[ "${cmdargs[1]}" = fg ]]; then
    # get the job id from the first argument passed to the fg command
    local job_id jobspec="${cmdargs[2]#%}"
    # logic based on jobs arguments:
    # http://zsh.sourceforge.net/Doc/Release/Jobs-_0026-Signals.html#Jobs
    # https://www.zsh.org/mla/users/2007/msg00704.html
    case "$jobspec" in
      <->) # %number argument:
        # use the same <number> passed as an argument
        job_id=${jobspec} ;;
      ""|%|+) # empty, %% or %+ argument:
        # use the current job, which appears with a + in $jobstates:
        # suspended:+:5071=suspended (tty output)
        job_id=${(k)jobstates[(r)*:+:*]} ;;
      -) # %- argument:
        # use the previous job, which appears with a - in $jobstates:
        # suspended:-:6493=suspended (signal)
        job_id=${(k)jobstates[(r)*:-:*]} ;;
      [?]*) # %?string argument:
        # use $jobtexts to match for a job whose command *contains* <string>
        job_id=${(k)jobtexts[(r)*${(Q)jobspec}*]} ;;
      *) # %string argument:
        # use $jobtexts to match for a job whose command *starts with* <string>
        job_id=${(k)jobtexts[(r)${(Q)jobspec}*]} ;;
    esac

    # override preexec function arguments with job command
    if [[ -n "${jobtexts[$job_id]}" ]]; then
      1="${jobtexts[$job_id]}"
      2="${jobtexts[$job_id]}"
    fi
  fi

  # cmd name only, or if this is sudo or ssh, the next cmd
  local CMD=${1[(wr)^(*=*|sudo|ssh|mosh|rake|-*)]:gs/%/%%}
  local LINE="${2:gs/%/%%}"

  title '$CMD' '%100>...>$LINE%<<'
}

autoload -U add-zsh-hook
add-zsh-hook precmd mzc_termsupport_precmd
add-zsh-hook preexec mzc_termsupport_preexec
# }}}

# Picom only needed for ST transparency,
# open it on ST startup.
#if ps -e | grep picom > /dev/null ; then
	# Picom is open
#else
#	picom -C -G -b --no-fading-openclose
#fi

maiaprompt() {
    # Normally: source /usr/share/zsh/zsh-maia-prompt
    GIT_PS1_SHOWDIRTYSTATE=true
    GIT_PS1_SHOWUNTRACKEDFILES=true
    GIT_PS1_SHOWUPSTREAM='git name verbose'
    GIT_PS1_SHOWCOLORHITS=true
    source ~/bin/git-prompt.sh

    setopt prompt_subst
    PROMPT="%B%{$fg[cyan]%}%(4~|%-1~/.../%2~|%~)%u %(?.%{$fg[cyan]%}.%{$fg[red]%})>%{$reset_color%}%b "
    RPROMPT='$(__git_ps1 " (%s)")'

    echo $USER@$HOST '   ' $(uname -sr)

    source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
    ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
}

# Normally: source/usr/share/zsh/manjaro-zsh-prompt
case $(basename "$(cat "/proc/$PPID/comm")") in
	login)
		maiaprompt
		alias x='startx ~/.xinitrc'
	;;
	*)
		if [[ $TERM == "linux" ]]; then
			# TTY does not have powerline fonts
			source /usr/share/zsh/zsh-maia-prompt
		elif [[ "$USE_POWERLINE" == "true" ]]; then
			# Use powerline
			source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
			[[ ! -f /usr/share/zsh/p10k.zsh ]] || source /usr/share/zsh/p10k.zsh
			source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
			ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
			ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
		else
			# Normally: source /usr/share/zsh/zsh-maia-prompt
			GIT_PS1_SHOWDIRTYSTATE=true
			GIT_PS1_SHOWUNTRACKEDFILES=true
			GIT_PS1_SHOWUPSTREAM='git name verbose'
			GIT_PS1_SHOWCOLORHITS=true
			source ~/bin/git-prompt.sh

			setopt prompt_subst
			PROMPT="%B%{$fg[cyan]%}%(4~|%-1~/.../%2~|%~)%u %(?.%{$fg[cyan]%}.%{$fg[red]%})>%{$reset_color%}%b "
			RPROMPT='$(__git_ps1 " (%s)")'

			echo $USER@$HOST '   ' $(uname -sr)

			source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
			ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
			ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
		fi
	;;
esac

# Set block cursor
echo -e "\e[?6c"

# Dracula colors for integrated terminal
#if [ "$TERM" = "what" ]; then # Disabled
#	printf %b '\e[40m' '\e[8]' # set default background to color 0 'dracula-bg'
#	printf %b '\e[37m' '\e[8]' # set default foreground to color 7 'dracula-fg'
#	printf %b '\e]P0282a36'    # redefine 'black'          as 'dracula-bg'
#	printf %b '\e]P86272a4'    # redefine 'bright-black'   as 'dracula-comment'
#	printf %b '\e]P1ff5555'    # redefine 'red'            as 'dracula-red'
#	printf %b '\e]P9ff7777'    # redefine 'bright-red'     as '#ff7777'
#	printf %b '\e]P250fa7b'    # redefine 'green'          as 'dracula-green'
#	printf %b '\e]PA70fa9b'    # redefine 'bright-green'   as '#70fa9b'
#	printf %b '\e]P3f1fa8c'    # redefine 'brown'          as 'dracula-yellow'
#	printf %b '\e]PBffb86c'    # redefine 'bright-brown'   as 'dracula-orange'
#	printf %b '\e]P4bd93f9'    # redefine 'blue'           as 'dracula-purple'
#	printf %b '\e]PCcfa9ff'    # redefine 'bright-blue'    as '#cfa9ff'
#	printf %b '\e]P5ff79c6'    # redefine 'magenta'        as 'dracula-pink'
#	printf %b '\e]PDff88e8'    # redefine 'bright-magenta' as '#ff88e8'
#	printf %b '\e]P68be9fd'    # redefine 'cyan'           as 'dracula-cyan'
#	printf %b '\e]PE97e2ff'    # redefine 'bright-cyan'    as '#97e2ff'
#	printf %b '\e]P7f8f8f2'    # redefine 'white'          as 'dracula-fg'
#	printf %b '\e]PFffffff'    # redefine 'bright-white'   as '#ffffff'
#	clear
#fi

# vim:foldmethod=marker
