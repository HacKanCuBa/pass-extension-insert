#!/usr/bin/env bash
#
# pass insert - Extension for Password Store Fork by HacKan 
# (https://github.com/HacKanCuBa/password-store)
# Copyright (C) 2017 HacKan <hackan@gmail.com>.
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

help_insert() {
    cat <<-_EOF
    $PROGRAM insert [--echo,-e | --multiline,-m] [--force,-f] pass-name [file-path]
        Insert new password. Optionally, echo the password back to the console
        during entry. Or, the entry may be multiline. 
        If file-path is a file, it will be inserted (options for 
        echo and multiline are ignored)
        Prompt before overwriting existing password or file unless forced.
_EOF
}

usage_insert() {
    cat <<-_EOF
Usage:
$(help_insert)

More information may be found in the pass-insert(1) man page.
_EOF
}

cmd_insert() {
    local opts multiline=0 noecho=1 force=0
    opts="$($GETOPT -o mef -l multiline,echo,force -n "$PROGRAM" -- "$@")"
    local err=$?
    eval set -- "$opts"
    while true; do case $1 in
        -m|--multiline) multiline=1; shift ;;
        -e|--echo) noecho=0; shift ;;
        -f|--force) force=1; shift ;;
        --) shift; break ;;
    esac done

    [[ $err -ne 0 || ( $multiline -eq 1 && $noecho -eq 0 ) || $# -lt 1 || $# -gt 2 ]] && die "Usage: $PROGRAM $COMMAND [--echo,-e | --multiline,-m] [--force,-f] pass-name [file-path]"
    local path="${1%/}"
    local passfile="$PREFIX/$path.gpg"
    check_sneaky_paths "$path"

    [[ $force -eq 0 && -e $passfile ]] && yesno "An entry already exists for $path. Overwrite it?"

    mkdir -p -v "$PREFIX/$(dirname "$path")"
    set_gpg_recipients "$(dirname "$path")"

    local pwdorfile="password"
    if [[ -n "${2}" ]]; then
        [[ -r "${2}" && -L "${2}" ]] && yesno "The file is a symlink and it's going to be resolved. Are you sure you want that?"

        if [[ -r "${2}" && -f "${2}" ]]; then
            pwdorfile="file"
            check_sneaky_paths "${2}"
            $GPG -e "${GPG_RECIPIENT_ARGS[@]}" -o "$passfile" "${GPG_OPTS[@]}" "${2}" || die "File encryption aborted."
        else
            die "File $2 is not valid."
        fi
    elif [[ $multiline -eq 1 ]]; then
        echo "Enter contents of $path and press Ctrl+D when finished:"
        echo
        $GPG -e "${GPG_RECIPIENT_ARGS[@]}" -o "$passfile" "${GPG_OPTS[@]}" || die "Password encryption aborted."
    elif [[ $noecho -eq 1 ]]; then
        local password password_again
        while true; do
            read -r -p "Enter password for $path: " -s password || exit 1
            echo
            read -r -p "Retype password for $path: " -s password_again || exit 1
            echo
            if [[ $password == "$password_again" ]]; then
                $GPG -e "${GPG_RECIPIENT_ARGS[@]}" -o "$passfile" "${GPG_OPTS[@]}" <<<"$password" || die "Password encryption aborted."
                break
            else
                die "Error: the entered passwords do not match."
            fi
        done
    else
        local password
        read -r -p "Enter password for $path: " -e password
        $GPG -e "${GPG_RECIPIENT_ARGS[@]}" -o "$passfile" "${GPG_OPTS[@]}" <<<"$password" || die "Password encryption aborted."
    fi
    git_add_file "$passfile" "Add given $pwdorfile for $path to store."
}

[[ "$1" == "help" || "$1" == "--help" || "$1" == "-h" ]] && usage_insert && exit 0

cmd_insert "$@"
