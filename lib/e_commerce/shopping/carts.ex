defmodule ECommerce.Shopping.Carts do
  alias ECommerce.Shopping.Cart
  alias ECommerce.Repo

  def create(params) do
    %Cart{}
    |> Cart.changeset(params)
    |> Repo.insert()
  end

  def find_by_id(id), do: Repo.get(Cart, id)

end
