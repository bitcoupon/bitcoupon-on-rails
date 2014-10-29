#!/bin/bash
cd admin
bundle install
RAILS_ENV=production rake db:migrate
RAILS_ENV=production bin/rake assets:precompile
echo -e "\n\nSTARTING BITCOUPON ADMIN\n\n"
rails server --port=3001 --environment=production
