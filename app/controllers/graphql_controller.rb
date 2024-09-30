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
    current_tenant = current_entity.tenant if current_entity.respond_to?(:tenant)

    context = {
      current_user: current_entity.is_a?(User) ? current_entity : nil,
      current_courier: current_entity.is_a?(Courier) ? current_entity : nil,
      headers: request.headers
    }

    if current_tenant
      ActsAsTenant.with_tenant(current_tenant) do
        result = FuelPandaSchema.execute(query, variables: variables, context: context, operation_name: operation_name)
        render json: result
      end
    else
      result = FuelPandaSchema.execute(query, variables: variables, context: context, operation_name: operation_name)
      render json: result
    end

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
end
