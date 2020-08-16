#!/bin/bash

cd

git clone https://github.com/UMDBPP/userland.git

cd 
cd userland

git checkout devel

./buildme
