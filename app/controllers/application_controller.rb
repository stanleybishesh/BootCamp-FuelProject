class ApplicationController < ActionController::API
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  # allow_browser versions: :modern
  set_current_tenant_through_filter
  before_action :find_current_tenant

  def find_current_tenant
    current_tenant = Tenant.find_it
    set_current_tenant(current_tenant)
  end
end
