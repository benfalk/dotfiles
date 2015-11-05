#!/usr/bin/env ruby
`tmux new-window -t #{ARGV[0]} -n 'SSH[#{ARGV[1]}]'`
`tmux send -t #{ARGV[0]} 'ssh #{ARGV[1]} && exit' ENTER`
