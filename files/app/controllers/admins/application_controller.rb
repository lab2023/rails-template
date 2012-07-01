# encoding: utf-8
require "application_responder"
class Admins::ApplicationController < ActionController::Base
  helper :all
  self.responder = ApplicationResponder
  respond_to :html, :json, :xml
  WillPaginate.per_page = 10

  before_filter :authenticate_admin!

  protect_from_forgery

end