#!/usr/local/bin/ruby
# This client needs the bunny clients, you can install it with gem, as follow :
# gem install bunny --version ">= 2.2.2"
#

require 'bunny'
require 'json'

class Producer

  attr_reader :connection, :queue, :channel

  attr_accessor :id_generator

  PAYLOAD_SIZE = 50

  def initialize
    @id_generator = 0
    @connection = Bunny.new(hostname: "localhost")
    puts " [ruby-producer] connected to : #{connection.inspect}"
    connection.start
    @channel = connection.create_channel
    @queue = channel.queue("prodcons")
  end

  def self.produce
    new().do_produce
  end

  def do_produce
    channel.default_exchange.publish(json_message, :routing_key => queue.name)
    puts " [ruby-producer] payload sent to queue \"#{queue.name}\""
    connection.close
  end

  def next_id
    @id_generator += 1
    id_generator
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
end
