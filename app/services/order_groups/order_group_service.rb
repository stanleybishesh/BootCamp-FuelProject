module OrderGroups
  class OrderGroupService
    attr_reader :params
    attr_accessor :success, :errors, :order_group, :order_groups, :delivery_orders, :recurring_orders, :non_recurring_orders, :client, :courier

    def initialize(params = {})
      @params = params
      @success = false
      @errors = []
    end

    def execute_create_order_group
      handle_create_order_group
      self
    end

    def execute_edit_order_group
      handle_edit_order_group
      self
    end

    def execute_delete_order_group
      handle_delete_order_group
      self
    end

    def execute_change_status_to_delivered
      change_status_to_delivered
      self
    end

    def execute_change_status_to_cancelled
      change_status_to_cancelled
      self
    end

    def execute_get_all_order_groups
      handle_get_all_order_groups
      self
    end

    def execute_get_all_delivery_orders
      handle_get_all_delivery_orders
      self
    end

    def execute_get_recurring_orders
      handle_get_recurring_orders
      self
    end

    def execute_get_main_recurring_orders
      handle_get_main_recurring_orders
      self
    end

    def execute_get_children_recurring_orders
      handle_get_children_recurring_orders
      self
    end

    def execute_get_non_recurring_orders
      handle_get_non_recurring_orders
      self
    end

    def success?
      @success || @errors.empty?
    end

    def errors
      @errors.join(", ")
    end

    private

    def handle_create_order_group
      begin
        user = current_user
        if user
          ActsAsTenant.with_tenant(user.tenant) do
            @order_group = OrderGroup.new(order_group_params)
            delivery_order_params = params[:delivery_order_attributes] || {}

            if @order_group.save
              @client = Client.find_by(id: order_group_params[:client_id])
              @courier = Courier.find_by(id: delivery_order_params[:courier_id])
              if @courier
                CreateOrderGroupMailer.courier_order_group_created_email(@courier, @order_group).deliver_later
              end
              if @client
                CreateOrderGroupMailer.client_order_group_created_email(@client, @order_group).deliver_later
              end
              @success = true
              @errors = []
              if @order_group.recurring_order?
                RecurringOrderJob.perform_async(@order_group.id)
                @success = true
                @errors = []
              end
            else
              @success = false
              @errors = @order_group.errors.full_messages
            end
          end
        else
          @success = false
          @errors << "User not logged in"
        end
      rescue StandardError => err
        @success = false
        @errors << "An unexpected error occurred: #{err.message}"
      end
    end

    def handle_edit_order_group
      begin
        user = current_user
        if user
          ActsAsTenant.with_tenant(user.tenant) do
            @order_group = OrderGroup.find(params[:order_group_id])
            raise ActiveRecord::RecordNotFound, "Order Group not found" if @order_group.nil?

            if @order_group.recurring_order?
              if @order_group.main_order_group_id.nil?
                @order_group.children_order_groups.each do |child_order|
                  unless @order_group.child_order_updated?(child_order)
                    child_order.update(order_group_params)
                  end
                  @order_group.update(order_group_params)
                  @success = true
                  @errors = []
                end
              else
                if @order_group.update(order_group_params)
                  @order_group.mark_child_order_as_updated(@order_group)
                  @success = true
                  @errors = []
                else
                  @success = false
                  @errors = [ @order_group.errors.full_messages ]
                end
              end
            else
              if @order_group.update(order_group_params)
                @success = true
                @errors = []
              else
                @success = false
                @errors = [ @order_group.errors.full_messages ]
              end
            end
          end
        else
          @success = false
          @errors << "User not logged in"
        end
      rescue ActiveRecord::RecordNotFound => err
        @success = false
        @errors << err.message
      rescue StandardError => err
        @success = false
        @errors << "An unexpected error occurred: #{err.message}"
      end
    end

    def handle_delete_order_group
      begin
        user = current_user
        if user
          ActsAsTenant.with_tenant(user.tenant) do
            @order_group = OrderGroup.find_by(id: params[:order_group_id])
            raise ActiveRecord::RecordNotFound, "Order Group not found" if @order_group.nil?

            if @order_group.recurring_order?
              if @order_group.main_order_group_id.nil?
                @order_group.children_order_groups.each do |child_order|
                  child_order.destroy
                end
              end
            end


            @client = @order_group.client
            if @order_group.destroy
              @success = true
              @errors = []
              DeleteOrderGroupMailer.order_group_deleted_email(@client).deliver_later

            else
              @success = false
              @errors = [ @order_group.errors.full_messages ]
            end
          end
        else
          @success = false
          @errors << "User not logged in"
        end
      rescue ActiveRecord::RecordNotFound, ActiveRecord::RecordNotDestroyed => err
        @success = false
        @errors << err.message
      rescue StandardError => err
        @success = false
        @errors << "An unexpected error occurred: #{err.message}"
      end
    end

    def change_status_to_delivered
      begin
        user = current_user
        if user
          ActsAsTenant.with_tenant(user.tenant) do
            @order_group = OrderGroup.find(params[:order_group_id])
            raise ActiveRecord::RecordNotFound, "Order Group not found" if @order_group.nil?
            @order_group.status = "delivered"
            if @order_group.status == "delivered"
              @success = true
              @errors = []
            else
              @success = false
              @errors = [ @order_group.errors.full_messages ]
            end
          end
        end
      rescue ActiveRecord::RecordNotFound => err
        @success = false
        @errors << err.message
      rescue StandardError => err
        @success = false
        @errors << "An unexpected error occurred: #{err.message}"
      end
    end

    def change_status_to_cancelled
      begin
        user = current_user
        if user
          ActsAsTenant.with_tenant(user.tenant) do
            @order_group = OrderGroup.find(params[:order_group_id])
            raise ActiveRecord::RecordNotFound, "Order Group not found" if @order_group.nil?
            @order_group.status = "cancelled"
            if @order_group.status == "cancelled"
              @success = true
              @errors = []
            else
              @success = false
              @errors = [ @order_group.errors.full_messages ]
            end
          end
        end
      rescue ActiveRecord::RecordNotFound => err
        @success = false
        @errors << err.message
      rescue StandardError => err
        @success = false
        @errors << "An unexpected error occurred: #{err.message}"
      end
    end

    def handle_get_all_order_groups
      begin
        user = current_user
        if user
          ActsAsTenant.with_tenant(user.tenant) do
            @order_groups = OrderGroup.where(main_order_group_id: nil)
            @success = true
            @errors = []
          end
        else
          @success = false
          @errors << "User not logged in"
        end
      rescue StandardError => err
        @success = false
        @errors << "An unexpected error occurred: #{err.message}"
      end
    end

    def handle_get_all_delivery_orders
      begin
        user = current_user
        if user
          ActsAsTenant.with_tenant(user.tenant) do
            @delivery_orders = DeliveryOrder.all
            @success = true
            @errors = []
          end
        else
          @success = false
          @errors << "User not logged in"
        end
      rescue StandardError => err
        @success = false
        @errors << "An unexpected error occurred: #{err.message}"
      end
    end

    def handle_get_recurring_orders
      begin
        user = current_user
        if user
          ActsAsTenant.with_tenant(user.tenant) do
            @recurring_orders = OrderGroup.all.select(&:recurring_order?)
            @success = true
            @errors = []
          end
        else
          @success = false
          @errors << "User not logged in"
        end
      rescue StandardError => err
        @success = false
        @errors << "An unexpected error occurred: #{err.message}"
      end
    end

    def handle_get_main_recurring_orders
      begin
        user = current_user
        if user
          ActsAsTenant.with_tenant(user.tenant) do
            @recurring_orders = OrderGroup.where(main_order_group_id: nil).select(&:recurring_order?)
            @success = true
            @errors = []
          end
        else
          @success = false
          @errors << "User not logged in"
        end
      rescue StandardError => err
        @success = false
        @errors << "An unexpected error occurred: #{err.message}"
      end
    end

    def handle_get_children_recurring_orders
      begin
        user = current_user
        if user
          ActsAsTenant.with_tenant(user.tenant) do
            main_recurring_order = OrderGroup.find_by(id: params[:main_recurring_order_id], main_order_group_id: nil)
            raise ActiveRecord::RecordNotFound, "Main Order Group does not exist" if main_recurring_order.nil?
            @recurring_orders = main_recurring_order.children_order_groups
            @success = true
            @errors = []
          end
        else
          @success = false
          @errors << "User not logged in"
        end
      rescue ActiveRecord::RecordNotFound => err
        @success = false
        @errors << [ err.message ]
      rescue StandardError => err
        @success = false
        @errors << "An unexpected error occurred: #{err.message}"
      end
    end

    def handle_get_non_recurring_orders
      begin
        user = current_user
        if user
          ActsAsTenant.with_tenant(user.tenant) do
            @non_recurring_orders = OrderGroup.all.reject(&:recurring_order?)
            @success = true
            @errors = []
          end
        else
          @success = false
          @errors << "User not logged in"
        end
      rescue StandardError => err
        @success = false
        @errors << "An unexpected error occurred: #{err.message}"
      end
    end

    def current_user
      params[:current_user]
    end

    def order_group_params
      ActionController::Parameters.new(params).permit(:tenant_id, :client_id, :venue_id, :start_on, :completed_on, :status, :manual_update,
        :main_order_group_id, recurring: [ :frequency, :start_date, :end_date ],
         delivery_order_attributes: [
          :order_group_id, :source, :vehicle_type, :transport_id, :courier_id,
           line_items_attributes: [
             :quantity, :delivery_order_id, :merchandise_id, :merchandise_category_id, :price, :unit
            ]
           ])
    end
  end
end
