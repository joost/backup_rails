# -*- encoding: utf-8 -*-
require File.expand_path('../lib/backup_rails/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Joost Hietbrink"]
  gem.email         = ["joost@joopp.com"]
  gem.description   = %q{Easy use backup gem with Rails.}
  gem.summary       = %q{Easy use backup gem with Rails.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "backup_rails"
  gem.require_paths = ["lib"]
  gem.version       = BackupRails::VERSION

  # For backup
  gem.add_dependency 'backup', '>= 3.1.3'
  gem.add_dependency 'fog', '~> 1.9.0' # Amazon S3, Rackspace Cloud Files (S3, CloudFiles Storages)
  gem.add_dependency 'excon' # HTTP Connection Support for Storages/Syncers
  gem.add_dependency 'net-ssh', '~> 2.3.0' # SSH Protocol (SSH Storage)
  gem.add_dependency 'net-sftp', '~> 2.0.5' # SFTP Protocol (SFTP Storage)
  gem.add_dependency 'mail', '>= 2.4.4' # Sending Emails (Mail Notifier)
  gem.add_dependency 'whenever' # For cronjob config, see config/schedule.rb
end
