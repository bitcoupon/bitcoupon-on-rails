rubocop

cd admin
echo -e "\n\nADMIN\n\n"
bundle exec rake test

cd ../backend
echo -e "\n\nBACKEND\n\n"
bundle exec rake test
