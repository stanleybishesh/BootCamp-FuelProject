class CreateOrderGroupMailer < ApplicationMailer
  def client_order_group_created_email(client, order_group)
    @client = client
    @order_group = order_group

    mail(
      to: @client.email,
      subject: "Order Group Created",
      from: "thapaabipinn@gmail.com"
    ) do |format|
      format.html { render html: generate_client_email.html_safe }
    end
  end

  def courier_order_group_created_email(courier, order_group)
    @courier = courier
    @order_group = order_group

    mail(
      to: @courier.email,
      subject: "New Delivery Order Assigned",
      from: "thapaabipinn@gmail.com"
    ) do |format|
      format.html { render html: generate_courier_email.html_safe }
    end
  end

  private

  def generate_client_email
    <<~HTML
      <h1>Hello #{@client.name},</h1>
      <p>Your order group has been successfully created!</p>
      <p>Order Group ID: #{@order_group.id}</p>
      <p>If you have any questions, please contact us.</p>
      <p>Best regards,<br>Fleet Panda</p>
    HTML
  end

  def generate_courier_email
    <<~HTML
      <h1>Hello #{@courier.first_name} #{@courier.last_name},</h1>
      <p>You have been assigned a new delivery order.</p>
      <p>Order Group ID: #{@order_group.id}</p>
      <p>Please check the order details in the system.</p>
      <p>Best regards,<br>Fleet Panda</p>
    HTML
  end
end
