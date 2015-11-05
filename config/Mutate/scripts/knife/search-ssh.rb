#!/usr/bin/env ruby
term = ARGV.join(' ')
exit(0) unless term =~ /\?$/
term.gsub!(/\?$/,'')

# Get an active tmux session
session = `tmux ls | grep attached | grep -o '^[^:]*'`.chomp
windows = `tmux list-windows -t #{session} | grep -o '^[^:]*'`.split("\n").map(&:to_i)
window = windows.max+1

Dir.chdir '/home/bfalk/Projects/chef-repo/'
results = `bundle exec knife search #{term} -a ipaddress -a uptime -a uptime_seconds`.split("\n\n")
results.shift
results.sort_by! { |r| r.match(/uptime_seconds:\W*(\d*)/)[1].to_i }

results.each do |result|
  ip = result.match(/^\W*ipaddress:\W*([\d\.]*)/)[1]
  puts "[#{ip}]"
  puts "command=/home/bfalk/.config/Mutate/scripts/knife/open.rb #{session}:#{window} #{ip}"
  puts 'icon=/home/bfalk/.config/Mutate/scripts/knife/server.png'
  puts "subtext=#{result.match(/uptime:.*$/)}"
end
