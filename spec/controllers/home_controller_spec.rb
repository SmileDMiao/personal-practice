require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe 'index' do
    let(:user) {create :login_user}

    it 'should show login link if user not signed in' do
      get :index
      expect(response).to redirect_to(login_path)
    end

  end

end
