defmodule ECommerce.Shopping.CartItems do
  alias ECommerce.Shopping.Cart
  alias ECommerce.Shopping.CartItem
  alias ECommerce.Shopping.Product
  alias ECommerce.Repo

  import Ecto.Query, warn: false

  def create(params) do
    CartItem
    |> where([c], c.product_id == ^params.product_id and c.cart_id == ^params.cart_id)
    |> Repo.one()
    |> case do
      # nil -> create_new_cart_item(params)
      # cart_item -> update_cart_item(cart_item, params)
    end

    # %CartItem{}
    # |> CartItem.changeset(params)
    # |> Repo.insert(conflict_target: :product_id, on_conflict: [])
  end

  def incremental_update do
  end

  def find_by_id(id), do: Repo.get(CartItem, id)
end
