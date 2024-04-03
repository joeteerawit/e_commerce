defmodule ECommerce.Shopping.Products do
  alias ECommerce.Shopping.Cart
  alias ECommerce.Shopping.Carts
  alias ECommerce.Shopping.CartItems
  alias ECommerce.Shopping.Product
  alias ECommerce.Repo
  alias ECommerce.Users

  import Ecto.Query, warn: false

  def all, do: Repo.all(ECommerce.Shopping.Product)

  def add_product_into_cart(%Product{} = prouduct, session_id) do
    with {:ok, user} <- Users.find_by_session_id(session_id),
         {:ok, cart} <- Carts.create(%{session_id: session_id, user_id: user.id}),
         {:ok, cart_item_payload} <- build_order_item_payload(prouduct, cart),
         {:ok, r} <- CartItems.create(cart_item_payload) do
      r
    end
  end

  defp build_order_item_payload(%Product{} = product, %Cart{} = cart),
    do:
      {:ok,
       %{
         quantity: 1,
         cart: cart,
         product: product
       }}
end
