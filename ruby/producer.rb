#!/usr/local/bin/ruby
# This client needs the bunny clients, you can install it with gem, as follow :
# gem install bunny --version ">= 2.2.2"
#

require 'bunny'
require 'json'

PAYLOAD_SIZE = 50

@id_generator = 0

def next_id
  @id_generator += 1
  @id_generator
end

def generate_random_payload
  (0...PAYLOAD_SIZE).map { ('a'..'z').to_a[rand(26)] }.join
end

def json_message
  {
    id: next_id,
    payload: generate_random_payload
  }.to_json
end

# Connect to the Rabbitmq server
connection = Bunny.new(hostname: "localhost")
connection.start
puts " [ruby-producer] connected to : #{connection.inspect}"

channel = connection.create_channel
queue = channel.queue("prodcons")

puts " [ruby-producer] queue \"#{queue.name}\" created"

channel.default_exchange.publish(json_message, :routing_key => queue.name)
puts " [ruby-producer] payload sent"

connection.close
