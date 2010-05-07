require 'yaml'
require 'versionomy'
require 'gemcutter_json'

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

  hydra = Typhoeus::Hydra.new(:max_concurrency => 20)
  gemcutter = GemcutterJson.new(hydra)

  gems.each do |name, v_current|
    gemcutter.latest_gem_version(name) do |v_latest, error|
      if error
        raise "Error fetching version for #{name} gem."
      else
        if Versionomy.parse(v_current) < Versionomy.parse(v_latest)
          outdated_gems[name] = "#{v_current} => #{v_latest}"
        end
      end
    end
  end

  hydra.run

  outdated_gems.each do |name, change|
    puts "#{name}: #{change}"
  end
end
