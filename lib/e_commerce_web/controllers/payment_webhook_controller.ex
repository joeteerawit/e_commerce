defmodule ECommerceWeb.Controllers.PaymentWebHookController do
  use ECommerceWeb, :controller

  alias ECommerce.Payments
  alias ECommerce.Emails

  def create(conn, %{
        "reference_id" => reference_id,
        "status" => "completed",
        "transaction_id" => transaction_id,
        "name" => name,
        "email" => email
      }) do
    Payments.update(reference_id, transaction_id, :success)
    |> case do
      {:ok, _} ->
        Task.Supervisor.start_child(ECommerce.AsyncEmailSupervisor, fn ->
          Emails.payment_success(name, email)
          |> ECommerce.Mailer.deliver()
        end)

        Task.Supervisor.start_child(ECommerce.AsyncEmailSupervisor, fn ->
          Emails.notify_order("joe walker shop", "test@email.com")
          |> ECommerce.Mailer.deliver()
        end)

        json(conn, :ok)

      {:error, _} ->
        json(conn, :error)
    end
  end

  def create(conn, %{
        "reference_id" => reference_id,
        "status" => _,
        "transaction_id" => transaction_id,
        "name" => name,
        "email" => email
      }) do
    Payments.update(reference_id, transaction_id, :failed)
    |> case do
      {:ok, _} ->
        Task.Supervisor.start_child(ECommerce.AsyncEmailSupervisor, fn ->
          Emails.payment_fail(name, email)
          |> ECommerce.Mailer.deliver()
        end)

        json(conn, :ok)

      {:error, _} ->
        json(conn, :error)
    end
  end
end
