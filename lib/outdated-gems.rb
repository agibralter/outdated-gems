if (bundle = `bundle show`) && !bundle.include?("Could not locate Gemfile")
  gems = {}
  bundle.each_line do |line|
    if line =~ /^\s+\* (.*?) \(([\w.]+)\)/
      gems[$~[1]] = $~[2]
    end
  end
  if gems.empty?
    puts bundle
  else
    outdated_gems = {}
    outdated_edge_gems = {}
    unfound_gems = []
    gem_list = Gem::SpecFetcher.new.list.values.first.reverse
    edge_gem_list = Gem::SpecFetcher.new.list(false, true).values.first.reverse
    gems.each do |name, v_current|
      latest_gem = gem_list.detect { |g| g.first == name }
      latest_edge_gem = edge_gem_list.detect { |g| g.first == name }
      if !latest_gem && !latest_edge_gem
        unfound_gems << name
      else
        if latest_gem && latest_gem[2] == "ruby" && latest_gem[1] > Gem::Version.create(v_current)
          outdated_gems[name] = "#{v_current} => #{latest_gem[1].version}"
        end
        if latest_edge_gem && latest_edge_gem[2] == "ruby" && latest_edge_gem[1] > Gem::Version.create(v_current)
          outdated_edge_gems[name] = "#{v_current} => #{latest_edge_gem[1].version}"
        end
      end
    end
    if outdated_gems.empty? && outdated_edge_gems.empty?
      puts "No outdated gems."
    else
      unless outdated_gems.empty?
        puts "\nOutdated gems:"
        puts "---"
        outdated_gems.each do |name, change|
          puts "#{name}: #{change}"
        end
        puts "---\n"
      end
      unless outdated_edge_gems.empty?
        puts "\nOutdated gems (including prereleases):"
        puts "---"
        outdated_edge_gems.each do |name, change|
          puts "#{name}: #{change}"
        end
        puts "---\n"
      end
    end
    unless unfound_gems.empty?
      puts "Could not find: #{unfound_gems.inspect}."
    end
  end
else
  puts bundle
end
