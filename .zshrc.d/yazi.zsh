function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	command rm -f -- "$tmp"
}

yazi_pick_path() {
  local -a files=("${(@f)$(yazi --chooser-file=>(cat))}")

  (( ${#files} == 0 )) || [[ -z "${files[1]}" ]] && zle redisplay && return

  LBUFFER+="${(j: :)${(@qqq)files}}"
  zle redisplay
}

zle -N yazi_pick_path
bindkey '\ey' yazi_pick_path
