#!/bin/bash

echo -e "\n\nADMIN\n\n"
cd admin
rake doc:app
echo -e "\n\nBACKEND\n\n"
cd ../backend
rake doc:app
cd ..
