begin
  require 'bones'
rescue LoadError
  abort '### Please install the "bones" gem ###'
end

require 'bundler/gem_tasks'

require 'yard'
YARD::Rake::YardocTask.new

require 'cucumber/rake/task'

Cucumber::Rake::Task.new do |t|
  t.cucumber_opts = %w{--tags ~@jruby} unless defined?(JRUBY_VERSION)
end

task :default => :cucumber