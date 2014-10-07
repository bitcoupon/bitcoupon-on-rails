#!/bin/bash

cd admin
rake doc:app
cd ../backend
rake doc:app
cd ..
