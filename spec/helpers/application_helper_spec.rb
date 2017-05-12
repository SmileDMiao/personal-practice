require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do

  describe 'Test time age helper method ' do
    it 'should work' do
      t = Time.now
      expect(helper.time_ago_now(t)).eq '于' + distance_of_time_in_words_to_now(t.iso8601) + '前发布'
    end

  end


  # TODO wait to be deleted
  # describe 'admin?' do
  #   let(:user) { create :user }
  #   let(:admin) { create :admin }
  #
  #   it 'knows you are not an admin' do
  #     expect(helper.admin?(user)).to be_falsey
  #   end
  #
  #   it 'knows who is the boss' do
  #     expect(helper.admin?(admin)).to be_truthy
  #   end
  #
  #   it 'use current_user if user not given' do
  #     allow(helper).to receive(:current_user).and_return(admin)
  #     expect(helper.admin?(nil)).to be_truthy
  #   end
  #
  #   it 'use current_user if user not given a user' do
  #     allow(helper).to receive(:current_user).and_return(user)
  #     expect(helper.admin?(nil)).to be_falsey
  #   end
  #
  #   it 'know you are not an admin if current_user not present and user param is not given' do
  #     allow(helper).to receive(:current_user).and_return(nil)
  #     expect(helper.admin?(nil)).to be_falsey
  #   end
  # end
  #
  #
  # describe 'owner?' do
  #   require 'ostruct'
  #   let(:user) { create :user }
  #   let(:user2) { create :user }
  #   let(:item) { OpenStruct.new user_id: user.id }
  #
  #   it 'knows who is owner' do
  #     expect(helper.owner?(nil)).to be_falsey
  #
  #     allow(helper).to receive(:current_user).and_return(nil)
  #     expect(helper.owner?(item)).to be_falsey
  #
  #     allow(helper).to receive(:current_user).and_return(user)
  #     expect(helper.owner?(item)).to be_truthy
  #
  #     allow(helper).to receive(:current_user).and_return(user2)
  #     expect(helper.owner?(item)).to be_falsey
  #   end
  # end
  #
  # describe 'insert_code_menu_items_tag' do
  #   it 'should work' do
  #     expect(helper.insert_code_menu_items_tag).to include('data-lang="ruby"')
  #   end
  # end

end
