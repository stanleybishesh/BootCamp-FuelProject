module Resolvers
  class BaseResolver < GraphQL::Schema::Resolver
    def current_user
      context[:current_user]
    end

    def current_courier
      context[:current_courier]
    end
  end
end
