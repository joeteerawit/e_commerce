defmodule ECommerce.Emails do
  import Swoosh.Email

  def welcome(user) do
    new()
    |> to({user.name, user.email})
    |> from({"Dr B Banner", "hulk.smash@example.com"})
    |> subject("Hello, Avengers!")
    |> html_body("<h1>Hello #{user.name}</h1>")
    |> text_body("Hello #{user.name}\n")
  end

  def payment_success(user_name, user_email) do
    new()
    |> to({user_name, user_email})
    |> from({"Joe walker e-commerce", "noreply@example.com"})
    |> subject("Payment successful")
    |> html_body("<h1>Payment successful</h1>")
    |> text_body("Payment successful")
  end

  def payment_fail(user_name, user_email) do
    new()
    |> to({user_name, user_email})
    |> from({"Joe walker e-commerce", "noreply@example.com"})
    |> subject("Payment failed")
    |> html_body("<h1>Payment failed</h1>")
    |> text_body("Payment failed")
  end

  def notify_order(shop_name, merchant_email) do
    new()
    |> to({shop_name, merchant_email})
    |> from({"Joe walker e-commerce", "noreply@example.com"})
    |> subject("Received new order")
    |> html_body("<h1>Received new order</h1>")
    |> text_body("Received new order")
  end
end
