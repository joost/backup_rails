 # env :PATH, ENV['PATH'] # '/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin'
# env :RAILS_ENV, ENV['RAILS_ENV']
# env :HOME, ENV['HOME']
# env :SHELL, ENV['SHELL']

env :MAILTO, 'your@email.com'

set :output, {:error => 'log/cron_error.log', :standard => '/dev/null'}
job_type :script, "cd :path && RAILS_ENV=:environment bundle exec script/:task :output"

# Backup using the RAILS_ROOT/config/backup.rb backup gem script.
# Schedule it using:
#   whenever
every 1.day, :at => '2:30 am' do
# every 1.minute do
  script 'backup'
end
