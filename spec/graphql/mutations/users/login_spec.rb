require 'rails_helper'

RSpec.describe 'Login', type: :request do
  let(:user) { create(:user, password: 'password') }
  let(:query) do
    <<-GRAPHQL
      mutation Login($loginData: UserLoginInputType!) {
        login(loginData: $loginData) {
          token
          user {
            id
            email
          }
          errors
        }
      }
    GRAPHQL
  end

  it 'logs in a user with correct credentials' do
    variables = {
      loginData: {
        email: user.email,
        password: 'password'
      }
    }

    result = execute_graphql(query, variables)

    expect(result.dig('data', 'login', 'token')).not_to be_nil
    expect(result.dig('data', 'login', 'user', 'email')).to eq(user.email)
    expect(result.dig('data', 'login', 'errors')).to be_empty
  end

  it 'returns error for invalid credentials' do
    variables = {
      loginData: {
        email: user.email,
        password: 'wrong_password'
      }
    }

    result = execute_graphql(query, variables)

    expect(result.dig('data', 'login', 'token')).to be_nil
    expect(result.dig('data', 'login', 'errors')).not_to be_empty
    expect(result.dig('data', 'login', 'errors')).to include("User does not exist or incorrect password")
  end
end
