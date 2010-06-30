begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "outdated-gems"
    gemspec.summary = "Given a Gemfile.lock, list gems that have new versions on rubyforge.org."
    gemspec.description = "Run `outdated_gems` in a directory containing a Gemfile.lock and it will print the results."
    gemspec.email = "aaron.gibralter@gmail.com"
    gemspec.homepage = "http://github.com/agibralter/outdated-gems"
    gemspec.authors = ["Aaron Gibralter"]
    gemspec.files = Dir['lib/**/*', 'bin/*', 'outdated-gems.gemspec', 'VERSION', 'README']
    gemspec.add_dependency("bundler", ">= 0.9.26")
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler not available. Install it with: gem install jeweler"
end
