set :application, "Schedule"
set :deploy_to, "/Users/adminosx/Sites/#{application}"
set :deploy_via, :export

set :rake, '/usr/local/bin/rake'
set :ruby,'/usr/local/bin/ruby'
set :gem, '/usr/local/bin/gem'


set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
set :repository,  "git@github.com:wccdpalay/#{application}.git"
set :branch, "Users"
set :scm_command, "/usr/local/git/bin/git"
set :local_scm_command, "git"


default_run_options[:pty] = true

set :ssh_options, {:forward_agent => true}
set :user, "adminosx"
set :group, "admin"


role :web, "207.72.2.8"                          # Your HTTP server, Apache/etc
role :app, "207.72.2.8"                          # This may be the same as your `Web` server
role :db,  "207.72.2.8", :primary => true # This is where Rails migrations will run


# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts



namespace :deploy do
  
  
  
  task :start, :roles => :app do
    run "touch #{current_release}/tmp/restart.txt"
    run "cp ~/Schedule_database.yml ~/Sites/Schedule/current/config/database.yml"
    run "cp ~/Sites/Schedule/Schedule_Dev.sqlite3 ~/Sites/Schedule/current/db/development.sqlite3"
    run "cd #{current_release}"
    run "#{rake} db:drop"
    run "#{rake} db:drop RAILS_ENV=arc"
    run "#{rake} db:migrate"
    run "#{rake} db:seed"
    run "#{rake} db:create RAILS_ENV=arc"
    run "#{rake} db:migrate RAILS_ENV=arc"
  end

  task :stop, :roles => :app do
    # Do nothing.
  end

  desc "Restart Application"
  task :restart, :roles => :app do
    run "cp ~/Schedule_database.yml ~/Sites/Schedule/current/config/database.yml"
    run "touch #{current_release}/tmp/restart.txt"
    run "cd #{current_release}"
    run "cp ~/Sites/Schedule/Schedule_Dev.sqlite3 ~/Sites/Schedule/current/db/development.sqlite3"
    run "#{rake} db:drop"
    run "#{rake} db:drop RAILS_ENV=arc"
    run "#{rake} db:migrate"
    run "#{rake} db:seed"
    run "#{rake} db:create RAILS_ENV=arc"
    run "#{rake} db:migrate RAILS_ENV=arc"
  end

end