require 'rails_helper'

module Resolvers
  module Clients
    RSpec.describe GetAllClients, type: :request do
      describe '.resolve' do
        let(:tenant) { create(:tenant) }
        let(:user) { create(:user, tenant: tenant) }

        before do
          allow_any_instance_of(Mutations::BaseMutation).to receive(:current_user).and_return(user)
        end

        context 'when user is logged in' do
          it 'retrieves all clients' do
            ActsAsTenant.with_tenant(tenant) do
              membership1 = create(:membership)
              membership2 = create(:membership)
              client1 = membership1.client
              client2 = membership2.client

              result = FuelPandaSchema.execute(
                query,
                context: { current_user: user },
                variables: {}
              )

              data = result['data']['getAllClients']

              expect(data).to be_an(Array)
              expect(data.size).to eq(2)
              expect(data).to include(
                include(
                  'id' => client1.id.to_s,
                  'name' => client1.name,
                  'email' => client1.email,
                  'address' => client1.address,
                  'phone' => client1.phone
                ),
                include(
                  'id' => client2.id.to_s,
                  'name' => client2.name,
                  'email' => client2.email,
                  'address' => client2.address,
                  'phone' => client2.phone
                )
              )
            end
          end
        end

        context 'when user is not logged in' do
          before do
            allow_any_instance_of(Mutations::BaseMutation).to receive(:current_user).and_return(nil)
          end

          it 'returns user not logged in error' do
            ActsAsTenant.with_tenant(tenant) do
              client = create(:client)
              create(:membership, client: client, tenant: tenant)

              post '/graphql', params: { query: query }
              json = JSON.parse(response.body)
              data = json['data']['getAllClients']

              expect(data).to be_nil
            end
          end
        end

        context 'when an unexpected error occurs' do
          before do
            allow_any_instance_of(::Clients::ClientService).to receive(:execute_get_all_clients).and_raise(StandardError, 'Unexpected failure')
          end

          it 'returns error message' do
            post '/graphql', params: { query: query }
            json = JSON.parse(response.body)
            data = json['data']['getAllClients']

            expect(data).to be_nil
          end
        end
      end

      def query
        <<~GQL
          query GetAllClients {
            getAllClients {
              id
              name
              email
              address
              phone
            }
          }
        GQL
      end
    end
  end
end
