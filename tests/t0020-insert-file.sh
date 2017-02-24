#!/usr/bin/env bash

test_description='Test insert extended command'
cd "$(dirname "$0")"
. ./setup.sh

TESTFILE1="$(mktemp "$SHARNESS_TRASH_DIRECTORY/XXXX.test")"
dd status=none if=/dev/urandom bs=100 count=1 of="$TESTFILE1"
TESTFILE2="$(mktemp "$SHARNESS_TRASH_DIRECTORY/XXXX.test")"
dd status=none if=/dev/urandom bs=100 count=1 of="$TESTFILE2"

test_expect_success 'Test init store' '
    "$PASSH" init $KEY1 &&
    [[ -e "$PASSWORD_STORE_DIR/.gpg-id" ]]
'

test_expect_success 'Test "insert" file' '
    "$PASSH" insert new-file "$TESTFILE1"
    [[ "$("$PASSH" show new-file)" == "$(cat "$TESTFILE1")" ]]
'

test_expect_success 'Test "insert --force" file' '
    "$PASSH" insert -f new-file "$TESTFILE2"
    [[ "$("$PASSH" show new-file)" == "$(cat "$TESTFILE2")" ]]
'

test_expect_failure 'Test "insert" nonexistent file' '
    "$PASSH" insert -f nonexistent-file /nonexistent
'

test_done
