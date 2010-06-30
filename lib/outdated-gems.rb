if (bundle = `bundle show`) && !bundle.include?("Could not locate Gemfile")
  gems = {}
  bundle.each_line do |line|
    if line =~ /^\s+\* (.*?) \(([\w.]+)\)/
      gems[$~[1]] = $~[2]
    end
  end
  outdated_gems = {}
  gem_list = Gem::SpecFetcher.new.list.values.first
  gems.each do |name, v_current|
    latest_gem = gem_list.detect { |g| g.first == name }
    if latest_gem[2] == "ruby" && latest_gem[1] > Gem::Version.create(v_current)
      outdated_gems[name] = "#{v_current} => #{latest_gem[1].version}"
    end
  end
  if outdated_gems.empty?
    puts "No outdated gems."
  else
    puts "Outdated gems:"
    outdated_gems.each do |name, change|
      puts "#{name}: #{change}"
    end
  end
else
  puts bundle
end
