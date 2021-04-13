# frozen_string_literal: true

require "rails_helper"
require "sidekiq/testing"
Sidekiq::Testing.fake!

RSpec.describe SchedulerFirstWorker, type: :worker do
  describe ".perform" do
    it "should work" do
      SchedulerFirstWorker.perform_async
      assert_equal 1, SchedulerFirstWorker.jobs.size
      SchedulerFirstWorker.drain
      assert_equal 0, SchedulerFirstWorker.jobs.size
    end
  end
end
