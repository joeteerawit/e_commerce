defmodule ECommerce.Shopping.OrderItems do
  alias ECommerce.Shopping.OrderItem
  alias ECommerce.Repo

  def create(params) do
    %OrderItem{}
    |> OrderItem.changeset(params)
    |> Repo.insert()
  end
end
