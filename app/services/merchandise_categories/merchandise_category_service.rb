module MerchandiseCategories
  class MerchandiseCategoryService
    attr_reader :params
    attr_accessor :success, :errors, :merchandise_category, :merchandise_categories

    def initialize(params = {})
      @params = params
      @success = false
      @errors = []
    end

    def execute_create_merchandise_category
      handle_create_merchandise_category
      self
    end

    def execute_update_merchandise_category
      handle_update_merchandise_category
      self
    end

    def execute_delete_merchandise_category
      handle_delete_merchandise_category
      self
    end

    def execute_get_all_merchandise_categories
      handle_get_all_merchandise_categories
      self
    end

    def execute_get_merchandise_category_by_id
      handle_get_merchandise_category_by_id
      self
    end

    def success?
      @success || @errors.empty?
    end

    def errors
      @errors.join(". ")
    end

    private

    def handle_create_merchandise_category
      begin
        @merchandise_category = MerchandiseCategory.new(merchandise_category_params)
        if @merchandise_category.save
          @success = true
          @errors = []
        else
          @success = false
          @errors = [ @merchandise_category.errors.full_messages ]
        end
      rescue StandardError => err
        @success = false
        @errors << "An unexpected error occured: #{err.message}"
      end
    end

    def handle_update_merchandise_category
      begin
        @merchandise_category = MerchandiseCategory.find(params[:merchandise_category_id])
        if @merchandise_category.update(merchandise_category_params)
          @success = true
          @errors = []
        else
          @success = false
          @errors = @merchandise_category.errors.full_messages
        end
      rescue StandardError => err
        @success = false
        @errors << "An unexpected error occurred: #{err.message}"
      end
    end


    def handle_delete_merchandise_category
      begin
        @merchandise_category = MerchandiseCategory.find(params[:merchandise_category_id])
        if @merchandise_category.destroy
          @success = true
          @errors = []
        else
          @success = false
          @errors = @merchandise_category.errors.full_messages
        end
      rescue StandardError => err
        @success = false
        @errors << "An unexpected error occurred: #{err.message}"
      end
    end

    def handle_get_all_merchandise_categories
      begin
        @merchandise_categories = MerchandiseCategory.all
        @success = true
        @errors = []
      rescue StandardError => err
        @success = false
        @errors << "An unexpected error occurred: #{err.message}"
      end
    end

    def handle_get_merchandise_category_by_id
      begin
        @merchandise_category = MerchandiseCategory.find(params[:merchandise_category_id])
        @success = true
        @errors = []
      rescue ActiveRecord::RecordNotFound
        @success = false
        @errors << "Merchandise category not found"
      rescue StandardError => err
        @success = false
        @errors << "An unexpected error occurred: #{err.message}"
      end
    end

    def merchandise_category_params
      ActionController::Parameters.new(params).permit(:name, :description)
    end
  end
end
