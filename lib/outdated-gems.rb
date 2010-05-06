require 'yaml'
require 'json'
require 'rest_client'
require 'versionomy'

file = File.join(Dir.pwd, 'Gemfile.lock')

if File.exists?(file)
  gemfile = File.open(file) { |yf| YAML::load(yf) }
  gems = gemfile['specs'].inject({}) do |gems, g|
    g = g.to_a[0]
    name = g[0]
    v = g[1]['version']
    v_latest = JSON.parse(RestClient.get("http://gemcutter.org/api/v1/gems/#{name}.json"))['version']
    if Versionomy.parse(v) < Versionomy.parse(v_latest)
      gems[name] = "#{v} => #{v_latest}"
    end
    gems
  end
  gems.each do |name, change|
    puts "#{name}: #{change}"
  end
end
