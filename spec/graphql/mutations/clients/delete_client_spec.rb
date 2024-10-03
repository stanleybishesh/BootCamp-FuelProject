require 'rails_helper'

module Mutations
  module Clients
    RSpec.describe DeleteClient, type: :request do
      describe '.resolve' do
        let(:tenant) { create(:tenant) }
        let(:user) { create(:user, tenant: tenant) }
        let!(:membership) { create(:membership) }
        let!(:client) { membership.client }

        before do
          allow_any_instance_of(Mutations::BaseMutation).to receive(:current_user).and_return(user)
        end

        context 'when user is logged in' do
          it 'deletes a client' do
            expect do
              ActsAsTenant.with_tenant(user.tenant) do
                post '/graphql', params: { query: query(client.id) }
              end
            end.to change { Client.count }.by(-1)
          end
        end

        context 'when user is not logged in' do
          before do
            allow_any_instance_of(Mutations::BaseMutation).to receive(:current_user).and_return(nil)
          end

          it 'returns user not logged in error' do
            post '/graphql', params: { query: query(client.id) }
            json = JSON.parse(response.body)
            data = json['data']['deleteClient']

            expect(data['client']).to be_nil
            expect(data['errors']).to include('User not logged in')
          end
        end

        context 'when client deletion fails' do
          before do
            allow_any_instance_of(::Clients::ClientService).to receive(:execute_delete_client).and_return(
              OpenStruct.new(success?: false, errors: 'Failed to delete client')
            )
          end

          it 'returns errors' do
            post '/graphql', params: { query: query(client.id) }
            json = JSON.parse(response.body)
            data = json['data']['deleteClient']

            expect(data['client']).to be_nil
            expect(data['errors']).to include('Failed to delete client')
          end
        end
      end

      def query(client_id)
        <<~GQL
          mutation{
            deleteClient(input:{
              clientId: #{client_id}
            }){
              message
              errors
            }
          }
        GQL
      end
    end
  end
end
