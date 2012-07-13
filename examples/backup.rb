# encoding: utf-8

# Put this file in rails_project/config/backup.rb

# This is the backup gem config file. Run it from the Rails root using:
#   backup perform --trigger your_project --config_file config/backup.rb --data-path db --log-path log --tmp-path tmp

# Read production db config from Rails app.
require 'yaml'
RAILS_ENV    = ENV['RAILS_ENV'] || 'development'
APP_ROOT = File.expand_path('..', File.dirname(__FILE__))
APP_DB_CONFIG = YAML.load_file(File.join(APP_ROOT, '/config/database.yml'))[RAILS_ENV]

##
# Backup Generated: my_backup
# Once configured, you can run the backup with the following command:
#
# $ backup perform -t my_backup [-c <path_to_configuration_file>]
#
Backup::Model.new(:your_project, 'Backup of YourProject DB and Assets') do
  ##
  # Split [Splitter]
  #
  # Split the backup file in to chunks of 250 megabytes
  # if the backup file size exceeds 250 megabytes
  #
  split_into_chunks_of 250

  ##
  # MySQL [Database]
  #
  database MySQL do |db|
    # To dump all databases, set `db.name = :all` (or leave blank)
    db.name               = APP_DB_CONFIG['database']
    db.username           = APP_DB_CONFIG['username']
    db.password           = APP_DB_CONFIG['password']
    db.host               = "localhost"
    db.port               = 3306
    # db.socket             = "/tmp/mysql.sock"
    # Note: when using `skip_tables` with the `db.name = :all` option,
    # table names should be prefixed with a database name.
    # e.g. ["db_name.table_to_skip", ...]
    # db.skip_tables        = ["skip", "these", "tables"]
    # db.only_tables        = ["only", "these" "tables"]
    db.additional_options = ["--quick", "--single-transaction"]
    # Optional: Use to set the location of this utility
    #   if it cannot be found by name in your $PATH
    # db.mysqldump_utility = "/opt/local/bin/mysqldump"
    # db.mysqldump_utility = "/usr/local/mysql-5.5.15-osx10.6-x86_64/bin/mysqldump"
  end

  store_with SFTP, "YourServer" do |server|
    server.username = 'user'
    # server.password = 'secret'
    server.ip       = 'your_server.nl'
    server.port     = 22
    server.path     = '~/backups'
    server.keep     = 5
  end

  ##
  # Gzip [Compressor]
  #
  # compress_with Gzip

  notify_by Mail do |mail|
    mail.on_success           = false
    mail.on_warning           = true
    mail.on_failure           = true

    mail.delivery_method      = :sendmail
    mail.from                 = 'no-reply@your_project.com'
    mail.to                   = 'your@email.com'
   
    # optional settings:
    # mail.sendmail             # the full path to the `sendmail` program
    # mail.sendmail_args        # string of arguments to to pass to `sendmail`
  end

end
