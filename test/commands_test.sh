#!/bin/bash

. test/assert.sh

STUBS=test/stubs
PATH="$STUBS:./:$PATH"
DOKKU_ROOT="test/fixtures/dokku"
dokku="PATH=$PATH DOKKU_ROOT=$DOKKU_ROOT commands"

# `redirects` requires an app name
assert "$dokku redirects" "You must specify an app name"
assert_raises "$dokku redirects" 1

# `redirects` requires an existing app
assert "$dokku redirects foo" "App foo does not exist"
assert_raises "$dokku redirects" 1

# `redirects:set` requires an app name
assert "$dokku redirects:set" "You must specify an app name"
assert_raises "$dokku redirects:set" 1

# `redirects:set` requires an existing app
assert "$dokku redirects:set foo" "App foo does not exist"
assert_raises "$dokku redirects:set foo" 1

# `redirects:set` requires at least one domain
assert "$dokku redirects:set rad-app" "Usage: dokku redirects:set APP DOMAIN1=DOMAIN2 [DOMAIN3=DOMAIN4 ...]\nMust specify a source DOMAIN and a destination DOMAIN."
assert_raises "$dokku redirects:set rad-app" 1

# `redirects:set` should create nginx-redirects.conf, call pluginhook, and reload nginx
assert "$dokku redirects:set rad-app radapp.com=www.radapp.com" "[stub: pluginhook nginx-pre-reload rad-app]\n[stub: sudo /etc/init.d/nginx reload]"
expected=$(< "test/expected/rad-app-nginx-redirects.conf")
assert "cat test/fixtures/dokku/rad-app/nginx-redirects.conf" "$expected"

# `redirects` should read the set redirects
assert "$dokku redirects rad-app" "radapp.com=www.radapp.com"

# `redirects:set` should create nginx-redirects.conf, call pluginhook, and reload nginx
assert "$dokku redirects:set rad-app radapp.com=www.radapp.com sub.radapp.com=www.radapp.com" "[stub: pluginhook nginx-pre-reload rad-app]\n[stub: sudo /etc/init.d/nginx reload]"
expected=$(< "test/expected/rad-app-nginx-redirects-second.conf")
assert "cat test/fixtures/dokku/rad-app/nginx-redirects.conf" "$expected"

# `redirects` should read the set redirects
assert "$dokku redirects rad-app" "radapp.com=www.radapp.com sub.radapp.com=www.radapp.com"

# end of test suite
assert_end examples

echo "" > test/fixtures/dokku/rad-app/REDIRECTS
