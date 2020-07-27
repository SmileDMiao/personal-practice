# frozen_string_literal: true

require "rails_helper"

RSpec.describe Article, type: :model do
  let(:user) { create(:user) }
  let(:article) { create(:article) }

  it "Test if article is liked by a user" do
    expect(article.liked_by_user?(user)).to eq false
    article.liked_user_ids << user.id
    article.save
    expect(article.liked_by_user?(user)).to eq true
  end

end
