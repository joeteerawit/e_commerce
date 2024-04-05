defmodule ECommerce.Payments do
  alias ECommerce.Payment
  alias ECommerce.Repo

  import Ecto.Query, warn: false

  def create(params) do
    %Payment{}
    |> Payment.changeset(params)
    |> Repo.insert()
  end

  def update(reference_id, transaction_id, status) do
    Payment
    |> Repo.get_by(reference_id: reference_id)
    |> case do
      nil ->
        {:error, "Payment not found"}

      payment ->
        payment
        |> Payment.changeset(%{transaction_id: transaction_id, status: status})
        |> Repo.update()
    end
  end

  def find_by_id(payment_id) do
    Repo.get(Payment, payment_id)
    |> case do
      nil ->
        :not_found

      payment ->
        {:ok, payment}
    end
  end
end
