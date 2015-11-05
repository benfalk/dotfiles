#!/usr/bin/env ruby
term = ARGV.join(' ')
exit(0) unless term =~ /\?$/
term.gsub!(/\?$/,'')

Dir.chdir '/home/bfalk/Projects/chef-repo/'
results = `bundle exec knife search #{term} -a ipaddress -a uptime -a uptime_seconds`.split("\n\n")
results.shift
results.sort_by! { |r| r.match(/uptime_seconds:\W*(\d*)/)[1].to_i }

results.each do |result|
  ip = result.match(/^\W*ipaddress:\W*([\d\.]*)/)[1]
  puts "[#{ip}]"
  puts "command=copy"
  puts 'icon=/home/bfalk/.config/Mutate/scripts/knife/server.png'
  puts "subtext=#{result.match(/uptime:.*$/)}"
end
