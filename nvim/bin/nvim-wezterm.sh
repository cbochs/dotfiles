#!/usr/bin/env sh

split_pane() {
	pane_id=$(wezterm cli get-pane-direction right)
	if [ -z "${pane_id}" ]
	then
		pane_id=$(wezterm cli split-pane --right)
	fi

	wezterm cli activate-pane --pane-id $pane_id

	send_to_bottom_pane="wezterm cli send-text --no-paste --pane-id $pane_id"

	program=$(wezterm cli list | awk -v pane_id=$pane_id '$3==pane_id { print $6 }')
	if [ "${program}" == "lazygit" ]
	then
		echo "q" | $send_to_bottom_pane
	fi
}

subcommand=$1
file_name=$2
line_number=$3

basedir=$(dirname "$file_name")
basename=$(basename "$file_name")
basename_without_extension="${basename%.*}"
extension="${file_name##*.}"

case "${subcommand}" in
	"lazygit")
		split_pane
		echo "lazygit" | $send_to_bottom_pane
		;;
	"open")
		gh browse $file_name
		;;
	"test")
		split_pane
		case "${extension}" in
			"rb")
				if [ -z "${line_number}" ]
				then
					run_command="docker compose exec portal bin/rspec ${file_name}"
				else
					run_command="docker compose exec portal bin/rspec ${file_name}:${line_number}"
				fi
				;;
			"rs")
				run_command="cargo test"
				;;
			"lua")
				run_command="echo 'hello, world!'"
				;;
		esac
		echo "${run_command}" | $send_to_bottom_pane
		;;
esac
