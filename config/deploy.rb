# config valid only for current version of Capistrano
lock '3.5.0'

set :application, 'screensmart'
set :repo_url, 'https://github.com/roqua/screensmart'

set :branch, :tr-test-default-capistrano-config

set :linked_files, fetch(:linked_files, []).push('.env.local')
