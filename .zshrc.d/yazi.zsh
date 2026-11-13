function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	command rm -f -- "$tmp"
}

yazi_pick_path() {
  local file=$(yazi --chooser-file=>(cat))

  [[ -z "$file" ]] && zle redisplay && return

  LBUFFER+="\"$file\""
  zle redisplay
}

zle -N yazi_pick_path
bindkey '\ey' yazi_pick_path
