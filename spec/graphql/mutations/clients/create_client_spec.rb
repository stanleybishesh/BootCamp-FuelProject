require 'rails_helper'

module Mutations
  module Clients
    RSpec.describe CreateClient, type: :request do
      describe '.resolve' do
        let(:tenant) { create(:tenant) }
        let(:user) { create(:user, tenant: tenant) }

        before do
          allow_any_instance_of(Mutations::BaseMutation).to receive(:current_user).and_return(user)
        end

        context 'when user is logged in' do
          it 'creates a client' do
            expect do
              ActsAsTenant.with_tenant(user.tenant) do
                post '/graphql', params: { query: query }
              end
            end.to change { Client.count }.by(1)
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

        context 'when client creation fails' do
          before do
            allow_any_instance_of(::Clients::ClientService).to receive(:execute_create_client).and_return(
              OpenStruct.new(success?: false, errors: 'Failed to create client')
            )
          end

          it 'returns errors' do
            post '/graphql', params: { query: query }
            json = JSON.parse(response.body)
            data = json['data']['createClient']

            expect(data['client']).to be_nil
            expect(data['errors']).to include('Failed to create client')
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
