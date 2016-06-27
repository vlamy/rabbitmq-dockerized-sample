# This client needs the bunny clients, you can install it with gem, as follow :
# gem install bunny --version ">= 2.2.2"
#

require 'bunny'
require 'json'

class Consumer

  attr_reader :connection, :queue

  def initialize
    @connection = Bunny.new(hostname: "localhost")
    connection.start
    puts " [ruby-consumer] connected to : #{connection.inspect}"
    channel = connection.create_channel
    @queue = channel.queue("prodcons")
  end

  def self.consume
    new().do_consume
  end

  def do_consume
    begin
      puts " [ruby-consumer] Waiting for messages in #{queue.name}. To exit press CTRL+C"
      queue.subscribe(:block => true) do |delivery_info, properties, body|
      puts " [ruby-consumer] Received #{body}"

      # cancel the consumer to exit
      delivery_info.consumer.cancel
    end
    rescue Interrupt => _
      connection.close
      exit(0)
    end
  end
end



