require 'json_web_token'

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
end
