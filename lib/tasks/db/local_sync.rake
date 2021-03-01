# frozen_string_literal: true

namespace :db do
  desc 'Sync staging db to local development db'
  # Prerequisite: set Heroku staging remote
  # $ heroku git:remote -r staging -a enrollment-engine-staging

  task local_sync: :environment do
    puts 'This task will replace your local development database for staging database!'
    puts 'Are you sure you want to continue? [y/N]'
    input = STDIN.gets.chomp
    raise 'Aborting db:local_sync.' unless input.downcase == 'y'

    puts 'Conectar server'
    #sh 'ssh root@104.131.66.189'
    puts 'Done!'

    puts 'Genera backup'
    # Descarga backup en el proyecto
    #sh 'ssh root@104.131.66.189 "pg_dump -U postgres -h localhost -C --column-inserts" > copia_labiziooooo.sql'
    sh 'rake db:drop db:create db:migrate'
    #sh 'PGPASSWORD="Postgres2017" pg_dump -U postgres -h localhost labizi5 > copia_labizi5.sql'
    #sh 'mv copia_labizi5.sql /var/lib/pgsql'
    #sh 'sudo -i -u postgres'
    #sh 'createdb -U postgres dbname'
    puts 'Done!'
=begin
    puts 'Migrate development database...'
    sh 'bundle exec rails db:migrate'
    puts 'Done!'

    puts 'Restore test database with development structure'
    sh 'bundle exec rails db:create RAILS_ENV=test'
    sh 'bundle exec rails parallel:create RAILS_ENV=test'
    sh 'bundle exec rails db:schema:dump RAILS_ENV=development'
    sh 'bundle exec rails parallel:load_schema RAILS_ENV=test'
=end
  end
end
