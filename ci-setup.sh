#!/bin/bash

[ `which rvm 2>/dev/null` ] || curl -sSL https://get.rvm.io | bash -s stable --ruby=1.9.3
[ `which rvm 2>/dev/null` ] || source .bashrc

#rvm use 1.9.3
gem install bundler
[ -d goldberg ] || git clone git://github.com/srushti/goldberg.git
cd goldberg
bundle install
rake db:setup
cd -
