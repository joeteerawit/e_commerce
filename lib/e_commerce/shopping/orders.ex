defmodule ECommerce.Shopping.Orders do
  alias ECommerce.Shopping.Order
  alias ECommerce.Repo

  import Ecto.Query, warn: false

  def create(params) do
    %Order{}
    |> Order.changeset(params)
    |> Repo.insert()
  end

  def find_by_user_id(user_id) do
    Order
    |> Repo.get_by(user_id: user_id, status: :created)
  end

  def update_to_paid_status(order_id) do
    Order
    |> Repo.get(order_id)
    |> case do
      nil ->
        {:error, :not_found}

      order ->
        order
        |> Order.changeset(%{status: :paid})
        |> Repo.update()
    end
  end
end
