# Use powerline
# This is the insane shit instead of a normal PS1
USE_POWERLINE="false"

# Source manjaro-zsh-configuration
if [[ -e /usr/share/zsh/manjaro-zsh-config ]]; then
  source /usr/share/zsh/manjaro-zsh-config
fi

# Picom only needed for ST transparency,
# open it on ST startup.
#if ps -e | grep picom > /dev/null ; then
	# Picom is open
#else
#	picom -C -G -b --no-fading-openclose
#fi

# Use manjaro zsh prompt
# Normally: source/usr/share/zsh/manjaro-zsh-prompt
case $(basename "$(cat "/proc/$PPID/comm")") in
  login)
	  source /usr/share/zsh/zsh-maia-prompt
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

