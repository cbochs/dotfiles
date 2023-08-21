#!/usr/bin/env sh

pane_id=$(wezterm cli get-pane-direction right)
if [ -z "${pane_id}" ]
then
	pane_id=$(wezterm cli split-pane --right)
fi

subcommand=$1
filename=$2
line_number=$3

basedir=$(dirname "$filename")
basename=$(basename "$filename")
basename_without_extension="${basename%.*}"
extension="${filename##*.}"

case "${subcommand}" in
	"lazygit")
		run_command="lazygit"
		;;
	"test")
		case "${extension}" in
			"rb")
				if [ -z "${line_number}" ]
				then
					run_command="docker compose exec portal bin/rspec ${filename}"
				else
					run_command="docker compose exec portal bin/rspec ${filename}:${line_number}"
				fi
				;;
			"rs")
				run_command="cargo test"
				;;
			"lua")
				run_command="echo 'hello, world!'"
				;;
		esac
		;;
esac

echo "${run_command}" | wezterm cli send-text --no-paste --pane-id $pane_id
