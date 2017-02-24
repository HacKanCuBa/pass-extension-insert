#!/usr/bin/env bash

test_description='Test insert extended command'
cd "$(dirname "$0")"
. ./setup.sh

PASSWORD1="echo "$RANDOM" | md5sum"
PASSWORD2="echo "$RANDOM" | md5sum"

test_expect_success 'Test init store' '
    "$PASSH" init $KEY1 &&
    [[ -e "$PASSWORD_STORE_DIR/.gpg-id" ]] 
'

test_expect_success 'Test "insert --echo"' '
	printf "%s" "$PASSWORD1" | "$PASSH" insert -e new-passwd &&
    [[ "$("$PASSH" show new-passwd)" == "$PASSWORD1" ]]
'

test_expect_success 'Test "insert --echo --force"' '
	printf "%s" "$PASSWORD2" | "$PASSH" insert -f -e new-passwd &&
    [[ "$("$PASSH" show new-passwd)" == "$PASSWORD2" ]]
'

test_expect_failure 'Test "insert" wrong options' '
    printf "%s" "$PASSWORD1" | "$PASSH" insert -e --nonexistent another
'

test_done
