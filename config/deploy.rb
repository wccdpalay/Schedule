set :application, "Schedule"
set :deploy_to, "/Users/adminosx/Sites/Schedule"
set :deploy_via, :export


set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
set :repository,  "git@github.com:wccdpalay/Schedule.git"
set :branch, "master"


default_run_options[:pty] = true

set :ssh_options, {:forward_agent => true}
set :user, adminosx
set :group, "admin"

role :web, "serafina.is.wccnet.org"                          # Your HTTP server, Apache/etc
role :app, "serafina.is.wccnet.org"                          # This may be the same as your `Web` server
role :db,  "serafina.is.wccnet.org", :primary => true # This is where Rails migrations will run


# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts


set :mongrel_cmd, "/usr/bin/mongrel_rails_persist"
set :mongrel_ports, 3000..3000



namespace :deploy do

  desc "Start Mongrels processes and add them to launchd."
  task :start, :roles => :app do
    mongrel_ports.each do |port|
      sudo "#{mongrel_cmd} start -p #{port} -e production \
            --user #{user} --group #{group} -c #{current_path}"
    end
  end

  desc "Stop Mongrels processes and remove them from launchd."
  task :stop, :roles => :app do
    mongrel_ports.each do |port|
      sudo "#{mongrel_cmd} stop -p #{port}"
    end
  end

  desc "Restart Mongrel processes"
  task :restart, :roles => :app do
    stop
    start
  end
 
end