# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :user_signup, mutation: Mutations::Users::UserSignUp
    field :login, mutation: Mutations::Users::Login
    field :logout, mutation: Mutations::Users::Logout
    field :create_client, mutation: Mutations::Clients::CreateClient
    field :edit_client, mutation: Mutations::Clients::EditClient
    field :delete_client, mutation: Mutations::Clients::DeleteClient
    field :create_merchandise, mutation: Mutations::Merchandises::CreateMerchandise
    field :delete_merchandise, mutation: Mutations::Merchandises::DeleteMerchandise
    field :update_merchandise, mutation: Mutations::Merchandises::UpdateMerchandise
    field :create_merchandise_category, mutation: Mutations::MerchandiseCategories::CreateMerchandiseCategory
    field :edit_merchandise_category, mutation: Mutations::MerchandiseCategories::EditMerchandiseCategory
    field :delete_merchandise_category, mutation: Mutations::MerchandiseCategories::DeleteMerchandiseCategory
    field :create_transport, mutation: Mutations::Transports::CreateTransport
    field :delete_transport, mutation: Mutations::Transports::DeleteTransport
    field :update_transport, mutation: Mutations::Transports::UpdateTransport
    field :create_venue, mutation: Mutations::Venues::CreateVenue
    field :edit_venue, mutation: Mutations::Venues::EditVenue
    field :delete_venue, mutation: Mutations::Venues::DeleteVenue
    field :courier_signin, mutation: Mutations::Couriers::CourierSignin
    field :courier_signout, mutation: Mutations::Couriers::CourierSignout
    field :create_order_group, mutation: Mutations::OrderGroups::CreateOrderGroup
    field :edit_order_group, mutation: Mutations::OrderGroups::EditOrderGroup
    field :delete_order_group, mutation: Mutations::OrderGroups::DeleteOrderGroup
  end
end
