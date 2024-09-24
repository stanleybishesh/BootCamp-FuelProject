
class DeleteOrderGroupMailer < ApplicationMailer
  # default from: "no-reply@example.com"
  def order_group_deleted_email(client)
    @client = client

    mail(
      to: @client.email,
      subject: "Order Group Deleted",
      from: "bishesh.shrestha@fleetpanda.com"
    ) do |format|
      format.html { render html: generate_html_email.html_safe }
    end
  end

  private

  def generate_html_email
    <<~HTML
      <h1>Hello #{@client.name},</h1>

      <p>We wanted to inform you that your order group has been successfully deleted.</p>

      <p>If you have any further questions, please don't hesitate to contact us.</p>

      <p>Best regards,<br>Fleet Panda</p>
    HTML
  end
end
