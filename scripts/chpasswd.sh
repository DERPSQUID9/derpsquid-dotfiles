#!/usr/bin/env bash
# chpasswd.sh: change passwords set with nixos-install.sh conveniently

# Sanity options for safety
# DO NOT set xtrace because this script handles passwords as variables
set -o errtrace \
	-o errexit \
	-o nounset \
	-o pipefail

# Config constants
readonly USERNAME="anomalocaris"
readonly PERSIST_DIR="/persist"
# Default to /persist/passwords
readonly PASSWORD_HASH_DIR="${1:-}$PERSIST_DIR/passwords"

# Show user where hashes will be created just in case
echo "Writing password hashes to $PASSWORD_HASH_DIR"

# Prompt for password
while true; do
	read -r -s -p "Password: " password </dev/tty
	echo ""
	read -r -s -p "Password (again): " password2 </dev/tty
	echo ""

	if [[ $password == "$password2" ]]; then
		if [[ -z $password ]]; then
			echo "ERROR: Password is empty. Please enter a different password."
		else
			break
		fi
	else
		echo "ERROR: Passwords do not match. Please re-enter password."
	fi
done

mkdir -p "$PASSWORD_HASH_DIR"
# Password may be the same, but calling mkpasswd twice ensures each hash has a different salt
mkpasswd "$password" --stdin --method=yescrypt >"$PASSWORD_HASH_DIR/root"
mkpasswd "$password" --stdin --method=yescrypt >"$PASSWORD_HASH_DIR/$USERNAME"
