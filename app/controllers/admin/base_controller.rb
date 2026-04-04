# frozen_string_literal: true

module Admin
  class BaseController < ApplicationController
    before_action :require_admin_or_author

    private

    def require_admin_or_author
      return if Current.user&.admin? || Current.user&.author?

      redirect_to root_path, alert: "Acesso não autorizado."
    end
  end
end
