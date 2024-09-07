# frozen_string_literal: true

class GraphqlController < ApplicationController
  # If accessing from outside this domain, nullify the session
  # This allows for outside API access while preventing CSRF attacks,
  # but you'll have to authenticate your user separately
  # protect_from_forgery with: :null_session
  include TokenHelper
  def execute
    variables = prepare_variables(params[:variables])
    query = params[:query]
    operation_name = params[:operationName]

    current_entity = current_entity_from_token
    current_tenant = ActsAsTenant.current_tenant

    context = {
      current_user: current_entity.is_a?(User) ? current_entity : nil,
      current_courier: current_entity.is_a?(Courier) ? current_entity : nil,
      current_tenant: current_tenant,
      headers: request.headers

      # current_user: current_user_from_token,
      # current_courier: current_courier_from_token
    }
    result = FuelPandaSchema.execute(query, variables: variables, context: context, operation_name: operation_name)
    render json: result
  rescue StandardError => e
    raise e unless Rails.env.development?
    handle_error_in_development(e)
  end

  private

  # Handle variables in form data, JSON body, or a blank value
  def prepare_variables(variables_param)
    case variables_param
    when String
      if variables_param.present?
        JSON.parse(variables_param) || {}
      else
        {}
      end
    when Hash
      variables_param
    when ActionController::Parameters
      variables_param.to_unsafe_hash # GraphQL-Ruby will validate name and type of incoming variables.
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{variables_param}"
    end
  end

  def handle_error_in_development(e)
    logger.error e.message
    logger.error e.backtrace.join("\n")

    render json: { errors: [ { message: e.message, backtrace: e.backtrace } ], data: {} }, status: 500
  end

  # def current_user_from_token
  #   token = request.headers["Authorization"].to_s.split(" ").last
  #   return unless token

  #   decoded_token = JWT.decode(token, "secret", true, algorithm: "HS256")
  #   return unless decoded_token[0]["type"] == "user" && decoded_token[0]["user_id"]

  #   user = User.find(decoded_token[0]["user_id"])

  #   if user.jti == decoded_token[0]["jti"]
  #     user
  #   else
  #     nil
  #   end
  # end

  # def current_courier_from_token
  #   token = request.headers["Authorization"].to_s.split(" ").last
  #   return unless token

  #   decoded_token = JWT.decode(token, "secret", true, algorithm: "HS256")
  #   return unless decoded_token[0]["type"] == "courier" && decoded_token[0]["courier_id"]

  #   courier = Courier.find(decoded_token[0]["courier_id"])

  #   if courier.jti == decoded_token[0]["jti"]
  #     courier
  #   else
  #     nil
  #   end
  # end

  # def current_entity_from_token
  #   token = request.headers["Authorization"].to_s.split(" ").last
  #   return unless token

  #   decoded_token = JWT.decode(token, "secret", true, algorithm: "HS256")[0]

  #   case decoded_token["type"]
  #   when "user"
  #     user = User.find_by(id: decoded_token["user_id"])
  #     return user if user && user.jti == decoded_token["jti"]
  #   when "courier"
  #     courier = Courier.find_by(id: decoded_token["courier_id"])
  #     return courier if courier && courier.jti == decoded_token["jti"]
  #   end

  #   nil # Return nil if neither user nor courier is authenticated
  # end
end
