module Venues
  class VenueService
    attr_reader :params
    attr_accessor :success, :errors, :venue, :venues

    def initialize(params = {})
      @params = params
      @success = false
      @errors = []
    end

    def execute_create_venue
      handle_create_venue
      self
    end

    def execute_edit_venue
      handle_edit_venue
      self
    end

    def execute_delete_venue
      handle_delete_venue
      self
    end

    def execute_get_venues_by_client_id
      handle_get_venues_by_client_id
      self
    end

    def success?
      @success || @errors.empty?
    end

    def errors
      @errors.join(", ")
    end

    private

    def handle_create_venue
      begin
        user = current_user
        if user
          ActsAsTenant.with_tenant(user.tenant) do
            membership = Membership.find_by(client_id: params[:client_id])
            raise ActiveRecord::RecordNotFound, "Client not found in this tenant" if membership.nil?
            client = Client.find(membership.client_id)
            @venue = client.venues.build(venue_params)
            if @venue.save
              @success = true
              @errors = []
            else
              @success = false
              @errors = [ @venue.errors.full_messages ]
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

    def handle_edit_venue
      begin
        user = current_user
        if user
          ActsAsTenant.with_tenant(user.tenant) do
            membership = Membership.find_by(client_id: params[:client_id])
            raise ActiveRecord::RecordNotFound, "Client not found in this tenant" if membership.nil?
            client = Client.find(membership.client_id)
            @venue = client.venues.find(params[:venue_id])
            if @venue.update(venue_params)
              @success = true
              @errors = []
            else
              @success = false
              @errors = [ @venue.errors.full_messages ]
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

    def handle_delete_venue
      begin
        user = current_user
        if user
          ActsAsTenant.with_tenant(user.tenant) do
            membership = Membership.find_by(client_id: params[:client_id])
            raise ActiveRecord::RecordNotFound, "Client not found in this tenant" if membership.nil?
            client = Client.find(membership.client_id)
            @venue = client.venues.find(params[:venue_id])
            if @venue.destroy
              @success = true
              @errors = []
            else
              @success = false
              @errors = [ @venue.errors.full_messages ]
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

    def handle_get_venues_by_client_id
      begin
        user = current_user
        if user
          ActsAsTenant.with_tenant(user.tenant) do
            membership = Membership.find_by(client_id: params[:client_id])
            raise ActiveRecord::RecordNotFound, "Client not found in this tenant" if membership.nil?
            client = Client.find(membership.client_id)
            @venues = client.venues
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

    def venue_params
      ActionController::Parameters.new(params).permit(:name, :client_id)
    end
  end
end
