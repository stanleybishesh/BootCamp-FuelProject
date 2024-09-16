require "sidekiq-scheduler"

class RecurringOrderJob
  include Sidekiq::Job

  def perform
    puts "Hello world"
  end
end
