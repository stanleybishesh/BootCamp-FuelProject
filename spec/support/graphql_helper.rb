module GraphQLHelpers
  def execute_graphql(query, variables = {}, context = {})
    FuelPandaSchema.execute(query, variables: variables, context: context)
  end
end
