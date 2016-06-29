#!/usr/local/bin/ruby
# Launches the RabbitMQ ruby samples
#
require_relative('consumer')
require_relative('producer')

role = ENV.fetch("BUNNY_ROLE", nil)

case role
when "producer"
  Producer.produce
when "consumer"
  Consumer.consume
when nil
  puts "please provide a value for env var BUNNY_ROLE"
else
  puts "unknown role #{role}"
end
