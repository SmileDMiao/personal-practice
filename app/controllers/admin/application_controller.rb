# frozen_string_literal: true

module Admin
  class ApplicationController < ::ApplicationController
    layout "admin"

    before_action :require_admin

    def require_admin
      return render_403 unless current_user.try(:admin?)
    end
  end
end
