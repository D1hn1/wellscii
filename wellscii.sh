TOML_FILE=$HOME"/.wellscii/wellscii.toml"
DOODLES_DIR=$HOME"/.wellscii/doodles/"

# Parse toml configuration

toml_get_all() { 
	grep -E "^\[.*?\]$" $1 
}

toml_get() {
	awk -v section="$1" -v key="$2" '
		/^\[.*\]/ {
			current = substr($0, 2, length($0) - 2)
			next
		}
		current == section {
			split($0, a, "=")
			k = a[1]
			gsub(/^[[:space:]]+|[[:space:]]+$/, "", k)
			if (k == key) {
				value = substr($0, index($0, "=") + 1)
				gsub(/^[[:space:]]+|[[:space:]]+$/, "", value)
				gsub(/^"|"$/, "", value)
				print value
				exit
			}
		}
	' "$3"
}

# Helper functions

check_date() {
	target_date=$((10#${1%%/*} + 100 * (10#${1#*/})))
	from_date=$((10#${2%%/*} + 100 * (10#${2#*/})))
	to_date=$((10#${3%%/*} + 100 * (10#${3#*/})))
	if (( (from_date <= to_date && target_date >= from_date && target_date <= to_date) ||
		(from_date > to_date && (target_date >= from_date || target_date <= to_date)))); then
		return 1
	fi
	return 0
}

print_doodle() {
	filename=$(find $DOODLES_DIR -name "$1*")
	if [ "$filename" != "" ]; then
		echo -e "$(cat $filename)"
	else
		echo "Error: <$1> doodle not found."
	fi
}

main() {
	# Actual system date
	system_date=$(date +%d/%m)

	all_headers=$(toml_get_all $TOML_FILE)
	for header in $all_headers; do
		clean_header=$(echo $header | sed -e "s/\[//g; s/\]//g")
		from_date=$(toml_get $clean_header from $TOML_FILE)
		to_date=$(toml_get $clean_header to $TOML_FILE)
		if [ "$from_date" = "*" ] && [ "$to_date" = "*" ]; then
			print_doodle $clean_header
			break
		else
			check_date $system_date $from_date $to_date
			if [ $? -eq 1 ]; then
				print_doodle $clean_header
				break
			fi
		fi
		
	done
}

main
