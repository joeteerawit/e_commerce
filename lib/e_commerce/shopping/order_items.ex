defmodule ECommerce.Shopping.OrderItems do
  alias ECommerce.Shopping.CartItem
  alias ECommerce.Shopping.OrderItem
  alias ECommerce.Repo
  alias Ecto.Multi

  import Ecto.Query, warn: false

  def create(cart_items, order_id) do
    order_items =
      cart_items
      |> Enum.map(fn %CartItem{
                       quantity: quantity,
                       product_id: product_id,
                       user_id: user_id
                     } ->
        %{
          quantity: quantity,
          order_id: order_id,
          product_id: product_id,
          user_id: user_id,
          inserted_at: DateTime.utc_now() |> DateTime.truncate(:second),
          updated_at: DateTime.utc_now() |> DateTime.truncate(:second)
        }
      end)

    Multi.new()
    |> Multi.insert_all(
      :insert_order_item,
      OrderItem,
      order_items
    )
    |> Repo.transaction()
  end

  def find_by_user_id(user_id) do
    Repo.all(
      from oi in OrderItem,
        where: oi.user_id == ^user_id,
        order_by: [desc: oi.inserted_at],
        preload: [:product]
    )
  end
end
