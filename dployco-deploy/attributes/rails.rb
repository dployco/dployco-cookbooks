
default['dployco']['deploy']['rails']['environment'] = 'production'


default['dployco']['deploy']['environment'] = {
  RAILS_ENV: default['dployco']['deploy']['rails']['environment']
}

default['dployco']['deploy']['bundle_install_command'] = "bundle install --deployment"
default['dployco']['deploy']['migration_command'] = "bundle exec rake db:migrate"

default['dployco']['deploy']['symlink_before_migrate'] = {
  "config/database.yml" => "config/database.yml"
}
