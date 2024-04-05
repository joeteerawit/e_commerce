defmodule ECommerce.Shopping.CartItems do
  alias ECommerce.Shopping.Cart
  alias ECommerce.Shopping.CartItem
  alias ECommerce.Repo

  import Ecto.Query, warn: false

  def add(params) do
    CartItem
    |> where(
      product_id: ^params.product.id,
      cart_id: ^params.cart.id
    )
    |> Repo.one()
    |> case do
      nil ->
        create_new_item(params)

      cart_item ->
        update_item(cart_item)
    end
  end

  def delete(%CartItem{} = cart_item), do: Repo.delete(cart_item)

  def find_by_id(id), do: Repo.get(CartItem, id)

  def find_total_items_in_cart(nil), do: []

  def find_total_items_in_cart(%Cart{id: cart_id}) do
    CartItem
    |> where(cart_id: ^cart_id)
    |> where(status: :active)
    |> preload([:product])
    |> Repo.all()
  end

  def update_inactive_items(cart_id) do
    CartItem
    |> where(cart_id: ^cart_id)
    |> Repo.update_all(set: [status: :inactive])
  end

  defp create_new_item(params),
    do:
      %CartItem{}
      |> CartItem.changeset(%{
        quantity: params.quantity,
        cart_id: params.cart.id,
        product_id: params.product.id,
        user_id: params.user.id
      })
      |> Repo.insert()

  defp update_item(%CartItem{quantity: quantity} = cart_item) do
    cart_item
    |> CartItem.changeset(%{quantity: quantity + 1})
    |> Repo.update()
  end

  def find_by_merchant_id(merchant_id) do
    CartItem
    |> join(:inner, [ci], p in assoc(ci, :product))
    |> where([ci, p], p.merchant_id == ^merchant_id)
    |> where([ci], ci.status == :active)
    |> preload([:product])
    |> Repo.all()
  end
end
