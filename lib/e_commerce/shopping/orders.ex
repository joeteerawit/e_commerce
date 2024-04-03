defmodule ECommerce.Shopping.Orders do
  alias ECommerce.Shopping.Order
  alias ECommerce.Repo

  def create(params) do
    %Order{}
    |> Order.changeset(params)
    |> Repo.insert()
  end
end
