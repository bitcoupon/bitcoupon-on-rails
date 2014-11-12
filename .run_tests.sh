cd backend
bundle exec rake db:migrate
bundle exec bin/rails s -p 3002 > /dev/null 2>&1 &
PID=$!
sleep 10
cd ../admin
echo -e "\n\nADMIN\n\n"
bundle exec rake test
kill -s INT $PID

cd ../backend
echo -e "\n\nBACKEND\n\n"
bundle exec rake test
