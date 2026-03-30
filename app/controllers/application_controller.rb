# frozen_string_literal: true

class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  protect_from_forgery
end
