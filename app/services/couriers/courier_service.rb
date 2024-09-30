module Couriers
  class CourierService
    attr_reader :params
    attr_accessor :success, :errors, :courier, :token

    def initialize(params = {})
      @params = params
      @success = false
      @errors = []
    end

    def execute_courier_login
      handle_courier_login
      self
    end

    def execute_courier_logout
      handle_courier_logout
      self
    end

    def success?
      @success || @errors.empty?
    end

    def errors
      @errors.join(", ")
    end

    private

    def handle_courier_login
      begin
        @courier = Courier.find_by(email: params[:email])
        if @courier
          if @courier&.valid_password?(params[:password])
            jti = SecureRandom.uuid
            @token = ::JWT.encode({ courier_id: @courier.id, jti: jti, exp: 1.day.from_now.to_i, type: "courier" }, "secret", "HS256")
            @courier.update(jti: jti)
            @success = true
            @errors = []
          else
            @success = false
            @errors << "Invalid Email or Password"
          end
        else
          @success = false
          @errors << "Courier not logged in"
        end
      rescue StandardError => err
        @success = false
        @errors << "An unexpected error occurred: #{err.message}"
      end
    end

    def handle_courier_logout
      begin
        @courier = current_courier
        if @courier
          new_jti = SecureRandom.uuid
          @courier.update(jti: new_jti)
          @success = true
          @errors = []
        else
          @success = false
          @errors << "Courier not logged in"
        end
      rescue StandardError => err
        @success = false
        @errors << "An unexpected error occurred: #{err.message}"
      end
    end

    def current_courier
      params[:current_courier]
    end
  end
end
