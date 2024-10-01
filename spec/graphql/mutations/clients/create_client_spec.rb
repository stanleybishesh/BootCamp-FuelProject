require 'rails_helper'

module Mutations
  module Clients
    RSpec.describe CreateClient, type: :request do
      describe '.resolve' do
        let(:user) { create(:user) }

        context 'when user is logged in' do
          before do
            allow_any_instance_of(Mutations::BaseMutation).to receive(:current_user).and_return(user)
          end

          it 'creates a client' do
            expect do
              post '/graphql', params: { query: query }
            end.to change { Client.count }.by(1)
          end

          it 'returns a client' do
            post '/graphql', params: { query: query }
            json = JSON.parse(response.body)
            data = json['data']['createClient']

            expect(data).to include(
              'client' => include(
                # 'id' => be_present,
                'name' => 'Bishesh',
                'email' => 'bishesh.shrestha@fleetpanda.com',
                'phone' => '9800000000',
                'address' => 'Imadol'
              ),
              'errors' => []
            )
          end
        end

        context 'when user is not logged in' do
          before do
            allow_any_instance_of(Mutations::BaseMutation).to receive(:current_user).and_return(nil)
          end

          it 'returns user not logged in error' do
            post '/graphql', params: { query: query }
            json = JSON.parse(response.body)
            data = json['data']['createClient']

            expect(data['client']).to be_nil
            expect(data['errors']).to include('User not logged in')
          end
        end
      end

      def query
        <<~GQL
          mutation{
            createClient(input:{
              clientInfo: {
                name: "Manisa"
                email: "manisa.mahat@fleetpanda.com"
                address: "KTM"
                phone: "9800000000"
              }
            }){
              client{
                id
                name
                email
                address
                phone
              }
              errors
            }
          }
        GQL
      end
    end
  end
end
