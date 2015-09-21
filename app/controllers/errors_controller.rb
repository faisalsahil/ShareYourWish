class ErrorsController < ApplicationController
  caches_page :bad_request, :unauthorized, :not_found, :internal_server_error
  before_filter :sign_out
  def bad_request
  end

  def unauthorized
  end

  def not_found
  end

  def internal_server_error
  end
end
