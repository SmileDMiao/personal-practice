module Admin

  class ApplicationController < ::ApplicationController
  	layout 'admin'

    before_action :require_admin

    def require_admin
      return render_403 unless current_user.admin?
    end

  end
end