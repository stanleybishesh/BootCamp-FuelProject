require 'rails_helper'

module Mutations
  module Clients
    RSpec.describe EditClient, type: :request do
      describe '.resolve' do
        let(:tenant) { create(:tenant) }
        let(:user) { create(:user, tenant: tenant) }
        let(:membership) { create(:membership) }

        before do
          allow_any_instance_of(Mutations::BaseMutation).to receive(:current_user).and_return(user)
        end

        context 'when user is logged in' do
          it 'edits a client' do
            client = membership.client
            expect do
              ActsAsTenant.with_tenant(user.tenant) do
                post '/graphql', params: { query: query(client.id) }
              end
            end.to change { client.reload.attributes.slice('name', 'email', 'phone', 'address') }
              .from({
                'name' => client.name,
                'email' => client.email,
                'phone' => client.phone,
                'address' => client.address
              })
              .to({ 'name' => 'Manisa', 'email' => 'manisa.mahat@fleetpanda.com', 'phone' => '9800000000', 'address' => 'KTM' })
          end
        end

        context 'when user is not logged in' do
          before do
            allow_any_instance_of(Mutations::BaseMutation).to receive(:current_user).and_return(nil)
          end

          it 'returns user not logged in error' do
            client = membership.client
            post '/graphql', params: { query: query(client.id) }
            json = JSON.parse(response.body)
            data = json['data']['editClient']

            expect(data['client']).to be_nil
            expect(data['errors']).to include('User not logged in')
          end
        end

        context 'when client update fails' do
          before do
            allow_any_instance_of(::Clients::ClientService).to receive(:execute_edit_client).and_return(
              OpenStruct.new(success?: false, errors: 'Failed to edit client')
            )
          end

          it 'returns errors' do
            client = membership.client
            post '/graphql', params: { query: query(client.id) }
            json = JSON.parse(response.body)
            data = json['data']['editClient']

            expect(data['client']).to be_nil
            expect(data['errors']).to include('Failed to edit client')
          end
        end
      end

      def query(client_id)
        <<~GQL
          mutation{
            editClient(input:{
              clientId: #{client_id},
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
