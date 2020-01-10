#!/usr/bin/env bash

if
  [[ -s "/Users/delonnewman/Projects/UNMH/yugo/vendor/jruby-9.2.9.0/jruby/2.5.0/environment" ]]
then
  source "/Users/delonnewman/Projects/UNMH/yugo/vendor/jruby-9.2.9.0/jruby/2.5.0/environment"
  exec jruby200.sh "$@"
else
  echo "ERROR: Missing RVM environment file: '/Users/delonnewman/Projects/UNMH/yugo/vendor/jruby-9.2.9.0/jruby/2.5.0/environment'" >&2
  exit 1
fi