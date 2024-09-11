class ApplicationController < ActionController::API
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  # allow_browser versions: :modern
  # set_current_tenant_through_filter
  # before_action :find_current_tenant

  # def find_current_tenant
  #   current_tenant = Tenant.find_it
  #   set_current_tenant(current_tenant)
  # end
  # around_action :set_current_user

  # def set_current_user
  #   RequestStore.store[:current_user] = current_user
  #   yield
  # ensure
  #   RequestStore.store[:current_user] = nil
  # end
end
