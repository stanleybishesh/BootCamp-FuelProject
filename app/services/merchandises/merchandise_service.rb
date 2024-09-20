module Merchandises
  class MerchandiseService
    attr_reader :params
    attr_accessor :success, :errors, :merchandise, :merchandises

    def initialize(params = {})
      @params = params
      @success = false
      @errors = []
    end

    def execute_create_merchandise
      handle_create_merchandise
      self
    end

    def execute_update_merchandise
      handle_update_merchandise
      self
    end

    def execute_delete_merchandise
      handle_delete_merchandise
      self
    end

    def execute_get_all_merchandises
      handle_get_all_merchandises
      self
    end

    def execute_get_merchandises_by_category
      handle_get_merchandises_by_category
      self
    end

    def success?
      @success || @errors.empty?
    end

    def errors
      @errors.join(", ")
    end

    private

    def handle_create_merchandise
      begin
        user = current_user
        if user
          ActsAsTenant.with_tenant(user.tenant) do
            merchandise_category = MerchandiseCategory.find(params[:merchandise_category_id])
            @merchandise = merchandise_category.merchandises.build(merchandise_params)
            if @merchandise.save
              @success = true
              @errors = []
            else
              @success = false
              @errors = @merchandise.errors.full_messages
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

    def handle_update_merchandise
      begin
        user = current_user
        if user
          ActsAsTenant.with_tenant(user.tenant) do
            @merchandise = Merchandise.find(params[:merchandise_id])
            if @merchandise.update(merchandise_params)
              @success = true
              @errors = []
            else
              @success = false
              @errors = @merchandise.errors.full_messages
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

    def handle_delete_merchandise
      begin
        user = current_user
        if user
          ActsAsTenant.with_tenant(user.tenant) do
            @merchandise = Merchandise.find(params[:merchandise_id])
            if @merchandise.destroy
              @success = true
              @errors = []
            else
              @success = false
              @errors = @merchandise.errors.full_messages
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

    def handle_get_all_merchandises
      begin
        user = current_user
        if user
          ActsAsTenant.with_tenant(user.tenant) do
            @merchandises = Merchandise.all
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

    def handle_get_merchandises_by_category
      begin
        user = current_user
        if user
          ActsAsTenant.with_tenant(user.tenant) do
            category = MerchandiseCategory.find(params[:merchandise_category_id])
            @merchandises = category.merchandises
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

    def merchandise_params
      ActionController::Parameters.new(params).permit(:name, :status, :description, :price, :unit, :merchandise_category_id)
    end
  end
end
