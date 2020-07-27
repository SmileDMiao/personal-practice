# frozen_string_literal: true

module UserSupport
  extend ActiveSupport::Concern

  included do
    def set_current_user
      let(:user) { create :user }
      @current_user = user
    end

  end
end
