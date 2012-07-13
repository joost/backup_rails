# Put this file in rails_project/config/schedule.rb

# Backup using the RAILS_ROOT/config/backup.rb backup gem script.
# Schedule it using:
#   whenever
every 1.day, :at => '2:30 am' do
  command "bundle exec backup perform --trigger your_project --config_file config/backup.rb --data-path db --log-path log --tmp-path tmp"
end