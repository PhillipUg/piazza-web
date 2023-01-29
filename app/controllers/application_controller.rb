class ApplicationController < ActionController::Base
  include Authenticate

  helper_method :turbo_frame_request?
end
