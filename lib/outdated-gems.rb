require 'yaml'

file = File.join(Dir.pwd, 'Gemfile.lock')

if File.exists?(file)
  gemfile = File.open(file) { |yf| YAML::load(yf) }
  gems = gemfile['specs'].inject({}) do |gems, g|
    g = g.to_a[0]
    name = g[0]
    version = g[1]['version']
    gems[name] = version
    gems
  end

  outdated_gems = {}

  gem_list = Gem::SpecFetcher.new.list.values.first

  gems.each do |name, v_current|
    latest_gem = gem_list.detect { |g| g.first == name }
    if latest_gem[1] > Gem::Version.create(v_current)
      outdated_gems[name] = "#{v_current} => #{latest_gem[1].version}"
    end
  end

  outdated_gems.each do |name, change|
    puts "#{name}: #{change}"
  end
end
