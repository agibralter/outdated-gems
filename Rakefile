begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "outdated-gems"
    gemspec.summary = "Given a Gemfile.lock, list gems that have new versions on rubyforge.org."
    gemspec.description = "Run `outdated_gems` in a directory containing a Gemfile.lock and it will print the results."
    gemspec.email = "aaron.gibralter@gmail.com"
    gemspec.homepage = "http://github.com/agibralter/outdated-gems"
    gemspec.authors = ["Aaron Gibralter"]
    gemspec.add_dependency('json', '>= 1.4.0')
    gemspec.add_dependency('monster_mash', '>= 0.1.0')
    gemspec.add_dependency('versionomy', '>= 0.3.0')
    gemspec.files = Dir['lib/**/*', 'bin/*', 'outdated-gems.gemspec', 'VERSION', 'README']
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler not available. Install it with: gem install jeweler"
end
