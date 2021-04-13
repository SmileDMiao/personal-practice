# frozen_string_literal: true

require "rails_helper"

RSpec.describe ApplicationHelper, type: :helper do
  describe "Test time age helper method " do
    it "should work" do
      t = Time.now
      expect(helper.time_ago_now(t)).to match("于" + distance_of_time_in_words_to_now(t.iso8601) + "前发布")
    end
  end

  describe "admin?" do
    let(:user) { create :user }
    let(:admin) { create :admin }

    it "you are not a admin" do
      expect(helper.admin?(user)).to be_falsey
    end

    it "you are a admin" do
      expect(helper.admin?(admin)).to be_truthy
    end
  end
end
