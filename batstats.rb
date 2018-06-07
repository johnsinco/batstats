require 'active_support'
require 'active_support/dependencies'
relative_load_paths = %w[lib models]
ActiveSupport::Dependencies.autoload_paths += relative_load_paths
