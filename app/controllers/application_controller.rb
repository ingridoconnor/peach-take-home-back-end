class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
  
    def get_csrf_token
      render json: { csrfToken: form_authenticity_token }
    end
  end
  