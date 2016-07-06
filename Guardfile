require "hesburgh_infrastructure"
# application_name must match an application in the hesburgh_infrastructure gem
# New applications must be added to config/applications.yml in hesburgh_infrastructure
hesburgh_guard = HesburghInfrastructure::Guard.new(:buzz, self)

# Spring used for preloading application
# https://github.com/guard/guard-spring
hesburgh_guard.spring do
  # Watch any custom paths
  watch(%r{^config/metadata/(.+)\.yml$}) { "spec/models/metadata/configuration/config_yml_spec.rb" }
end

hesburgh_guard.rails do
  # Watch any custom paths
end
