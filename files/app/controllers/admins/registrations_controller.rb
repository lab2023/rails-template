class Admins::RegistrationsController < Devise::RegistrationsController
  def new
    redirect_to admins_dashboard_index_path
  end

  def create
    redirect_to admins_dashboard_index_path
  end

  def update
    super
  end
  protected

  def after_update_path_for(resource)
    admins_dashboard_index_path
  end
end
