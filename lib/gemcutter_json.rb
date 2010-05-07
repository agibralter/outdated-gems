require 'monster_mash'
require 'json'

class GemcutterJson < MonsterMash::Base
  get(:latest_gem_version) do |name|
    uri "http://gemcutter.org/api/v1/gems/#{name}.json"
    handler do |response|
      JSON.parse(response.body)['version']
    end
  end
end
