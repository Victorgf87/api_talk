require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  # Catch all CanCan errors and alert the user of the exception
     rescue_from CanCan::AccessDenied do | exception |
       redirect_to root_url, alert: exception.message
     end

end
