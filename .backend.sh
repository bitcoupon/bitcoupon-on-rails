#!/bin/bash
cd backend
bundle install
RAILS_ENV=production rake db:migrate
RAILS_ENV=production bin/rake assets:precompile
echo -e "\n\nSTARTING BITCOUPON BACKEND\n\n"
rails server --port=3002 --environment=production
