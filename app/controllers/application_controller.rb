class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protect_from_forgery with: :exception

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :first_name_kana, :last_name_kana, :postal_code, :address, :telephone_number])
  end

  def after_inactive_sign_up_path_for(resource_or_scope)
    if resource_or_scope.is_a?(Admin)
        admin_path(resource_or_scope)
    else
        customer_path(resource_or_scope)
    end
  end

  def after_sign_in_path_for(resource_or_scope)
    if resource_or_scope.is_a?(Admin)
        admin_path
    else
        root_path
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :customer
        root_path
    elsif resource_or_scope == :admin
        new_admin_session_path
    else
        root_path
    end
  end
end
