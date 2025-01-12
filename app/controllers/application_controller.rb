class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource)
    authenticated_root_path
  end

  def current_ability
    @current_ability ||= ability_class.new(current_user)
  end

  private

  def ability_class
    "#{controller_name.classify}Ability".constantize
  end
end
