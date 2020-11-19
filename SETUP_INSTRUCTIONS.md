## Rails setup

we want

- Rails
- Bootstrap
- React (maybe stimulus)

we want to do

- make build - to verify our code is all good
- git push
- make deploy_staging
- make deploy_production

Check a CI build

-

### Instructions

1. [✅] rename the repo to **remote-button** - any suggestions?

1. [✅] clone the repo

   ```
   git@github.com:failure-driven/remote-button.git
   cd hard-hack/
   ```

1. [✅] check your version of ruby and rails

   ```
   ruby -v
   ruby 2.7.1

   rails -v
   Rails 6.0.3.4
   ```

1. [✅] rails new in the current directory

   ```
   rails new remote-button --database=postgresql --skip-test
   ```

1. [✅] get rails up and running

   ```
   rails db:create
   rails server
   open http://localhost:3000
   ```

1. [✅] commit and push

   ```
   # set a common commit message
   cat > .git/.gitmessage


   Co-authored-by: Bence Fulop <fbence90@gmail.com>
   Co-authored-by: Lily Tan <lilyt2995@gmail.com>
   Co-authored-by: Mathieu Longe <mathieu.longe@orange.fr>
   Co-authored-by: Michael Milewski <saramic@gmail.com>
   ^D

   # and setup git to use it
   git config commit.template .git/.gitmessage

   git add .
   # with a message like
   # :tada: rails new
   git commit -v

   git push
   ```

1. [✅] add code linting

   ```
   # add to Gemfile
   gem "rubocop"

   bundle

   # add a setupfile
   wget https://raw.githubusercontent.com/saramic/real-code-runner/master/.rubocop.yml

   rubocop -a .
   # then autogen a todo config
   rubocop --auto-gen-config

   # git add and commit
   ```

1. [✅] add make script to build

   ```
   cat > Makefile
   PROJECT := remote-button

   default: usage
   usage:
     bin/makefile/usage

   .PHONY: build
   build:
     bin/full-build
   ^D

   cat > bin/full-build
   #!/usr/bin/env bash

   set -e

   bundle install
   yarn

   bundle exec rubocop
   ^D

   # make executable
   chmod 755 bin/full-build

   # make sure any tabs are actual tab characters!!! in Makefile above

   mkdir bin/makefile
   wget https://raw.githubusercontent.com/saramic/real-code-runner/master/bin/makefile/usage
   mv usage bin/makefile
   # edit usage file for what we need

   # make executable
   chmod 755 bin/makefile/usage

   # try the make targets
   make
   make build
   ```

1. [✅] add testing framework

   ```
   # add to Gemfile
   group :test do
     gem "database_cleaner"

     gem "rspec-example_steps"
     gem "rspec-rails"
     gem "rspec-wait"

     gem "capybara", ">= 3.14"
     gem "capybara-screenshot"
     gem "selenium-webdriver"
     gem "webdrivers", "~> 3.0"

     gem "pry"
     gem "pry-byebug"
     gem "pry-rails"
     gem "pry-stack_explorer"
   end

   # install and generate
   bundle
   rails generate rspec:install

   # add rspec to bin/full-build
   bundle exec rspec

   # add capybara setup
   wget https://raw.githubusercontent.com/saramic/interactive-slide-show/master/spec/support/capybara.rb
   mkdir spec/support
   mv capybara.rbb spec/support

   # add page fragments
   wget https://raw.githubusercontent.com/saramic/interactive-slide-show/master/spec/support/features/page_fragments.rb
   mkdir -p spec/support/page_fragments
   mv page_fragments.rb spec/support/

   # add page fragments and capybara to rails_helper.rb
   vi spec/rails_helper.rb

     # near top
     Dir['spec/support/**/*.rb'].each do |file|
       require Rails.root.join(file).to_s
     end

     # near bottom
     # include PageFragments in features
     config.include PageFragments, type: :feature

   ```

1. [✅] a first test for a landing page

   ```
   mkdir spec/features
   cat > spec/features/it_works_spec.rb
   require 'rails_helper'

   feature 'It works', js: true do
     scenario 'I have rails' do
       When 'user visits the app' do
         visit root_path
       end

       Then 'user sees they are on rails' do
         wait_for { focus_on(:welcome).message_and_versions }.to include(
           message: "Yay! You’re on Rails!",
           rails_version: match(/^6.0.3.4/),
           ruby_version: match(/^ruby 2.7.1/)
         )
       end
     end
   end
   ^D

   cat > spec/support/page_fragments/welcome.rb
   module PageFragments
     module Welcome
       def message_and_versions
         output = {}
         output[:message] = browser.find('h1').text
         version = browser.find('p.version')
         output[:rails_version] = version.text[/(Rails version: )(?<version>[^\n]*)/, 'version']
         output[:ruby_version] = version.text[/(Ruby version: )(?<version>[^\n]*)/, 'version']
         output
       end
     end
   end
   ^D

   # run the spec
   rspec

   # add a root path to config/routes.rb
   root to: "rails/welcome#index"

   # run build, git add and commit
   ```

1. [✅] add CI

   ```
   wget https://raw.githubusercontent.com/failure-driven/bdd-workshop-app/master/.circleci/config.yml
   mkdir .circleci
   mv config.yml .circleci/

   # some edits and sort out on circle CI manually
   ```

1. [✅] add deploy script

   ```
   # add make target
   .PHONY: deploy
   deploy:
     RAILS_MASTER_KEY=`cat config/master.key` \
       HEROKU_APP_NAME=stg-real-code-runner   \
       bin/heroku-create

   wget https://raw.githubusercontent.com/saramic/real-code-runner/master/bin/heroku-create
   mv heroku-create bin/
   # modify above

   # generate a master key and share between all but DO NOT commit
   # ie file config/master.key
   rails credentials:edit

   # git add and commit
   ```

1. [✅] UUID for database id's

   ```
   # as per
   open https://github.com/saramic/real-code-runner/commit/f5af59dd90ad69c461374ca76ab44c99c0f02656

   rails generate migration EnablePgcryptoExtension

     class EnablePgcryptoExtension < ActiveRecord::Migration[6.0]
       def change
         enable_extension "pgcrypto"
       end
     end

   # edit config/application.rb
   config.generators do |g|
     g.orm :active_record, primary_key_type: :uuid
   end
   ```

1. [✅] Bootstrap for styling

   ```
   open https://github.com/saramic/real-code-runner/commit/edc6503b576bff63ef32d4bfb800e2c0343904c0
   ```

1. [ ] React for JS

   ```
   rails webpacker:install:react
   # as per
   open https://github.com/saramic/real-code-runner/commit/1f34e7bcbd57e417d36a598ed8db7f903c2bec35
   ```

1. [✅] Write first 3 stories

1. [ ] Get email's working and tested

- using this template https://github.com/leemunroe/responsive-html-email-template

1. [ ] Get background jobs working

- to send users reminders
