#! /bin/bash

bash -l <<EOF
cd $1
RAILS_ENV=production PG_PASS=$PG_PASS rake thinking_sphinx:rebuild
EOF
