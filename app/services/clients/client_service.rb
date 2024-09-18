module Clients
  class ClientService
    attr_reader :params
    attr_accessor :success, :errors, :client, :clients

    def initialize(params = {})
      @params = params
      @success = false
      @errors = []
    end

    def execute_create_client
      handle_create_client
      self
    end

    def execute_edit_client
      handle_edit_client
      self
    end

    def execute_delete_client
      handle_delete_client
      self
    end

    def execute_get_all_clients
      handle_get_all_clients
      self
    end

    def execute_get_client_by_id
      handle_get_client_by_id
      self
    end

    def success?
      @success || @errors.empty?
    end

    def errors
      @errors.join(", ")
    end

    private

    def handle_create_client
      begin
        user = current_user
        if user
          ActsAsTenant.with_tenant(user.tenant) do
            ActiveRecord::Base.transaction do
              @client = Client.new(client_params)
              if @client.save
                membership = Membership.new(client_id: @client.id)
                if membership.save
                  @success = true
                  @errors = []
                else
                  @success = false
                  @errors = [ membership.errors.full_messages ]
                end
              else
                @success = false
                @errors = [ @client.errors.full_messages ]
              end
            end
          end
        else
          @success = false
          @errors << "User not logged in"
        end
      rescue ActiveRecord::Rollback => err
        @success = false
        @errors << err.message
      rescue StandardError => err
        @success = false
        @errors << "An unexpected error occurred: #{err.message}"
      end
    end

    def handle_edit_client
      begin
        user = current_user
        if user
          ActsAsTenant.with_tenant(user.tenant) do
            membership = Membership.find_by(client_id: params[:client_id])
            raise ActiveRecord::RecordNotFound, "Client's membership not found" if membership.nil?
            @client = Client.find(membership.client_id)
            if @client
              updated_client = @client.update(client_params)
              if updated_client
                @success = true
                @errors = []
              else
                @success = false
                @errors = [ @client.errors.full_messages ]
              end
            else
              @success = false
              @errors << "Client does not exist in this tenant"
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

    def handle_delete_client
      begin
        user = current_user
        if user
          ActsAsTenant.with_tenant(user.tenant) do
            membership = Membership.find_by(client_id: params[:client_id])
            raise ActiveRecord::RecordNotFound, "Client's membership not found" if membership.nil?
            @client = Client.find(membership.client_id)
            if @client
              if @client.destroy && membership.destroy
                @success = true
                @errors = []
              else
                @success = false
                @errors = [ @client.errors.full_messages ]
              end
            else
              @success = false
              @errors << "Client does not exist in this tenant"
            end
          end
        else
          @success = false
          @errors << "User not logged in"
        end
      rescue ActiveRecord::RecordNotDestroyed, ActiveRecord::RecordNotFound => err
        @success = false
        @errors << err.message
      rescue StandardError => err
        @success = false
        @errors << "An unexpected error occurred: #{err.message}"
      end
    end

    def handle_get_all_clients
      begin
        user = current_user
        if user
          ActsAsTenant.with_tenant(user.tenant) do
            memberships = Membership.all
            @clients = Client.where(id: memberships.select(:client_id))
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

    def handle_get_client_by_id
      begin
        user = current_user
        if user
          ActsAsTenant.with_tenant(user.tenant) do
            membership = Membership.find_by(client_id: params[:client_id])
            raise ActiveRecord::RecordNotFound, "Client's membership not found" if membership.nil?
            @client = Client.find(membership.client_id)
            raise ActiveRecord::RecordNotFound, "Client not found" if @client.nil?
            @success = true
            @errors = []
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

    def current_user
      params[:current_user]
    end

    def client_params
      ActionController::Parameters.new(params).permit(:name, :email, :address, :phone)
    end
  end
end
