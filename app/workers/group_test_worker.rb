# frozen_string_literal: true

class GroupTestWorker
  # batch_unique prevents enqueue of jobs with identical arguments.
  include Sidekiq::Worker
  include Sidekiq::Status::Worker
  sidekiq_options queue: :group, retry: false, backtrace: true, batch_flush_size: 30, batch_flush_interval: 60

  def perform(numbers)
    numbers = numbers.flatten
    numbers.each do |n|
      name = "#{n}Sidekiq Group!!!"
      Food.create!(name: name, category: "Sidekiq Group", number: n)
    end
  end
end
