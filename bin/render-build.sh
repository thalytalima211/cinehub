#!/usr/bin/env bash

set -o errexit

bundle install
bin/rails assets:precompile

bin/rails db:migrate

echo "Arquivos gerados:"
find public/assets -type f
