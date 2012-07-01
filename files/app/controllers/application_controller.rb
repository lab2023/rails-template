# encoding: utf-8
require "application_responder"
class ApplicationController < ActionController::Base
  helper :all
  self.responder = ApplicationResponder
  respond_to :html, :json, :xml
  WillPaginate.per_page = 10

  before_filter :authenticate_user!

  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Yetkisiz erişim."
    redirect_to root_url
  end

  def after_sign_in_path_for(resource_or_scope)
    unless current_admin
      super
    else
      admins_dashboard_index_path
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    unless current_admin
      super
    else
      admins_dashboard_index_path
    end
  end
end