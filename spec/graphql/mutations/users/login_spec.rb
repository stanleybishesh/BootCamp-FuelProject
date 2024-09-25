require "rails_helper"

RSpec.describe "mutation user login" do
  it "authenticates returning a token" do
    query = <<~GQL
    mutation{
      login(input:{
        loginData:{
          email: "bishesh@gmail.com",
          password: "123123"
        }
      }){
        token
      }
    }
    GQL

    result = 
  end
end
